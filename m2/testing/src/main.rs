use fvm_integration_tests::tester::{Account, Tester};
use fvm_integration_tests::dummy::DummyExterns;
use fvm_integration_tests::bundle;
use fvm_ipld_encoding::{strict_bytes, tuple::*};
use fvm_shared::state::StateTreeVersion;
use fvm_shared::version::NetworkVersion;
use fvm_ipld_blockstore::MemoryBlockstore;
use fvm_shared::address::Address;
use std::env;
use std::str::FromStr;
use fvm_shared::message::Message;
use fvm::executor::{ApplyKind, Executor};
use fil_actor_eam::Return;
use cid::Cid;
use fvm_ipld_encoding::RawBytes;
use fil_actors_runtime::{INIT_ACTOR_ADDR, EAM_ACTOR_ADDR};

#[macro_use] extern crate prettytable;
use prettytable::Table;

const WASM_COMPILED_PATH: &str =
    "../build/Precompile.bin";

#[derive(Serialize_tuple, Deserialize_tuple, Clone, Debug)]
struct State {
    empty: bool,
}

#[derive(Serialize_tuple, Deserialize_tuple)]
pub struct Create2Params {
    #[serde(with = "strict_bytes")]
    pub initcode: Vec<u8>,
    #[serde(with = "strict_bytes")]
    pub salt: [u8; 32],
}

fn main() {
    println!("Testing solidity precompiles");

    let actors = std::fs::read("./builtin-actors-devnet-wasm.car").expect("Unable to read actor devnet file file");

    let bs = MemoryBlockstore::default();
    let bundle_root = bundle::import_bundle(&bs, &actors).unwrap();

    let mut tester =
        Tester::new(NetworkVersion::V18, StateTreeVersion::V4, bundle_root, bs).unwrap();

    let sender: [Account; 1] = tester.create_accounts().unwrap();

    let wasm_path = env::current_dir()
    .unwrap()
    .join(WASM_COMPILED_PATH)
    .canonicalize()
    .unwrap();
    let evm_bin = std::fs::read(wasm_path).expect("Unable to read file");

    let constructor_params = Create2Params {
        initcode: evm_bin,
        salt: [0; 32],
    };

    // Instantiate machine
    tester.instantiate_machine(DummyExterns).unwrap();

    let executor = tester.executor.as_mut().unwrap();

    println!("Calling init actor (EVM)");

    let message = Message {
        from: sender[0].1,
        to: EAM_ACTOR_ADDR,
        gas_limit: 1000000000,
        method_num: 3,
        params: RawBytes::serialize(constructor_params).unwrap(),
        ..Message::default()
    };

    let res = executor
        .execute_message(message, ApplyKind::Explicit, 100)
        .unwrap();

    assert_eq!(res.msg_receipt.exit_code.value(), 0);

    let exec_return : Return = RawBytes::deserialize(&res.msg_receipt.return_data).unwrap();

    println!("Calling `test`");

    let message = Message {
        from: sender[0].1,
        to: Address::new_id(exec_return.actor_id),
        gas_limit: 1000000000,
        method_num: 2,
        sequence: 1,
        params: RawBytes::new(hex::decode("44f8a8fd6d").unwrap()),
        ..Message::default()
    };

    let res_test = executor
        .execute_message(message, ApplyKind::Explicit, 100)
        .unwrap();

    assert_eq!(res_test.msg_receipt.exit_code.value(), 0);

    println!("Calling `cborBoolean`");

    let message = Message {
        from: sender[0].1,
        to: Address::new_id(exec_return.actor_id),
        gas_limit: 1000000000,
        method_num: 2,
        sequence: 2,
        params: RawBytes::new(hex::decode("44d073f9a3").unwrap()),
        ..Message::default()
    };

    let res_serialize_bool = executor
        .execute_message(message, ApplyKind::Explicit, 100)
        .unwrap();

    assert_eq!(res_serialize_bool.msg_receipt.exit_code.value(), 0);

    println!("Calling `sha256`");

    let message = Message {
        from: sender[0].1,
        to: Address::new_id(exec_return.actor_id),
        gas_limit: 1000000000,
        method_num: 2,
        sequence: 3,
        params: RawBytes::new(hex::decode("4479320f2b").unwrap()),
        ..Message::default()
    };

    let res_sha256 = executor
        .execute_message(message, ApplyKind::Explicit, 100)
        .unwrap();

    assert_eq!(res_sha256.msg_receipt.exit_code.value(), 0);

    println!("Calling `cborAddress`");

    let message = Message {
        from: sender[0].1,
        to: Address::new_id(exec_return.actor_id),
        gas_limit: 1000000000,
        method_num: 2,
        sequence: 4,
        params: RawBytes::new(hex::decode("446195f26f").unwrap()),
        ..Message::default()
    };

    let res_cbor_address = executor
        .execute_message(message, ApplyKind::Explicit, 100)
        .unwrap();

    assert_eq!(res_cbor_address.msg_receipt.exit_code.value(), 0);

    let mut table = Table::new();
    table.add_row(row!["FUNCTIONS", "GAS USED"]);
    table.add_row(row!["test",
        format!("{}", res_test.msg_receipt.gas_used),
    ]);
    table.add_row(row!["sha256",
        format!("{}", res_sha256.msg_receipt.gas_used),
    ]);
    table.add_row(row!["cborBoolean",
        format!("{}", res_serialize_bool.msg_receipt.gas_used),
    ]);
    table.add_row(row!["cborAddress",
        format!("{}", res_cbor_address.msg_receipt.gas_used),
    ]);

    table.printstd();
}
