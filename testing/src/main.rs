use fvm_integration_tests::tester::{Account, Tester};
use fvm_integration_tests::dummy::DummyExterns;
use fvm_integration_tests::bundle;
use fvm_ipld_encoding::tuple::*;
use fvm_shared::state::StateTreeVersion;
use fvm_shared::version::NetworkVersion;
use fvm_ipld_blockstore::MemoryBlockstore;
use fvm_shared::address::Address;
use std::env;
use std::str::FromStr;
use fvm_shared::message::Message;
use fvm::executor::{ApplyKind, Executor};
use fil_actor_init::ExecParams;
use cid::Cid;
use fvm_ipld_encoding::RawBytes;
use fil_actors_runtime::INIT_ACTOR_ADDR;

const WASM_COMPILED_PATH: &str =
    "../build/CborTest.bin";

#[derive(Serialize_tuple, Deserialize_tuple, Clone, Debug)]
struct State {
    empty: bool,
}

#[derive(Serialize_tuple, Deserialize_tuple, Clone, Debug)]
struct EVMcontract {
    pub contract_bytes: RawBytes,
    pub empty: RawBytes,
}

fn main() {
    println!("Testing solidity CBOR actor");

    let actors = std::fs::read("./builtin-actors-devnet-wasm.car").expect("Unable to read actor devnet file file");

    let bs = MemoryBlockstore::default();
    let bundle_root = bundle::import_bundle(&bs, &actors).unwrap();

    let mut tester =
        Tester::new(NetworkVersion::V16, StateTreeVersion::V4, bundle_root, bs).unwrap();

    let sender: [Account; 1] = tester.create_accounts().unwrap();

    let wasm_path = env::current_dir()
    .unwrap()
    .join(WASM_COMPILED_PATH)
    .canonicalize()
    .unwrap();
    let evm_bin = std::fs::read(wasm_path).expect("Unable to read file");

    let constructor_params = EVMcontract {
        contract_bytes: RawBytes::new(evm_bin),
        empty: RawBytes::new(vec![])
    };

    // Instantiate machine
    tester.instantiate_machine(DummyExterns).unwrap();

    let executor = tester.executor.as_mut().unwrap();

    println!("Calling init actor (EVM)");

    let params = ExecParams {
        code_cid: Cid::from_str("bafk2bzacecnt43raaasddv6kqtcxp5tuj4nziava53e6fi6c7as5rlvyc2e5q").unwrap(),
        constructor_params: RawBytes::serialize(constructor_params).unwrap(),
    };

    let message = Message {
        from: sender[0].1,
        to: INIT_ACTOR_ADDR,
        gas_limit: 1000000000,
        method_num: 2,
        params: RawBytes::serialize(params).unwrap(),
        ..Message::default()
    };

    let res = executor
        .execute_message(message, ApplyKind::Explicit, 100)
        .unwrap();

    dbg!(&res);

    assert_eq!(res.msg_receipt.exit_code.value(), 0);

}
