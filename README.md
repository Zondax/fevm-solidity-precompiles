# FEVM Precompiles
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![GithubActions](https://github.com/Zondax/fevm-solidity-precompiles/actions/workflows/m1.main.yaml/badge.svg)](https://github.com/Zondax/fevm-solidity-precompiles/blob/main/.github/workflows/m1.main.yaml)
[![GithubActions](https://github.com/Zondax/fevm-solidity-precompiles/actions/workflows/m2.main.yaml/badge.svg)](https://github.com/Zondax/fevm-solidity-precompiles/blob/main/.github/workflows/m2.main.yaml)

---

![zondax_light](docs/assets/zondax_light.png#gh-light-mode-only)
![zondax_dark](docs/assets/zondax_dark.png#gh-dark-mode-only)

_Please visit our website at [zondax.ch](https://www.zondax.ch)_

---

# M1: CBOR on Solidity

## Related documentation

### Entry point for calling function
Please, read this [doc](https://docs.soliditylang.org/en/v0.8.16/abi-spec.html#function-selector)

Example:

```solidity
        // sendCoin(address,uint) --> Keccak-256 --> first 4 bytes --> 38f633e9
        function sendCoin(address receiver, uint amount) public returns(bool sufficient) {
                if (balances[msg.sender] < amount) return false;
                balances[msg.sender] -= amount;
                balances[receiver] += amount;
                emit Transfer(msg.sender, receiver, amount);
                return true;
        }
```

## Benchmarking

### Serializing an address compare to a send message

serializeAddress : 82006530
simple send tx: 413868

We have +19814% gas use compare to a simple send transaction when serializing address from address to cbor format.

### More benchmarking

```
|------------------------------------|----------------------|
| Call                               | Gas used             |
|------------------------------------|----------------------|
| serializeAddSigner (CBOR contract) | 107,072,567          |
| serializeAddress (CBOR contract)   |  82,175,116          |
| serializeBool (CBOR contract)      |  14,151,467          |
| getBalance (SimpleCoin contract)   |   9,321,353          |
| ERC20 send (assemblyscript native) |     697,452          |
| Simple send (native)               |     413,868          |
|------------------------------------|----------------------|
```

### Benchmark Selenium

```
|------------------------------------|----------------------|
| Call                               | Gas used             |
|------------------------------------|----------------------|
| serializeAddSigner (CBOR contract) |  13,922,379          |
| serializeAddress (CBOR contract)   |  11,341,547          |
| serializeBool (CBOR contract)      |   3,719,855          |
| getBalance (SimpleCoin contract)   |   3,356,533          |
|------------------------------------|----------------------|
```

### Benchmark Copper

```
|------------------------------------|----------------------|
| Call                               | Gas used             |
|------------------------------------|----------------------|
| serializeAddSigner (CBOR contract) |  14,602,887          |
| serializeAddress (CBOR contract)   |  11,930,295          |
| serializeBool (CBOR contract)      |   4,042,787          |
| getBalance (SimpleCoin contract)   |   3,665,937          |
|------------------------------------|----------------------|
```


### Reproducing result

b10d18b8 -> serializeAddSigner(address,bool)

```
$ ./lotus chain create-evm-actor CborTest.bin
sending message...
waiting for message to execute...
ID Address: t01056
Robust Address: t2dn7qowffhiygdmba3hsum6roquyhhqrh4y74rbq
Return: gkMAoAhVAht/B1ilOjBhsCDZ5UZ6LoUwc8In

$ ./lotus chain invoke-evm-actor t01056 b10d18b8 00000000000000000000000000000000000000000000000000000000000000640000000000000000000000000000000000000000000000000000000000000001
sending message...
waiting for message to execute...
0000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000582420064f5000000000000000000000000000000000000000000000000000000

$ ./lotus state list-messages --to t01056
{
  "Version": 0,
  "To": "t01056",
  "From": "t3q4pntto27catfcuo5kj672pvjicabkyjoqavbovles2hb462z7r6oiukvd6lhs6skfss4vbytn4uffkodgma",
  "Nonce": 165,
  "Value": "0",
  "GasLimit": 133834208,
  "GasFeeCap": "101727",
  "GasPremium": "100673",
  "Method": 2,
  "Params": "gVhEsQ0YuAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAE=",
  "CID": {
    "/": "bafy2bzacecf2ndxvisedvijglbwt2rmqwczcc4jmlqg2qizdjuikqeiecbhec"
  }
}

$ ./lotus state search-msg bafy2bzacecf2ndxvisedvijglbwt2rmqwczcc4jmlqg2qizdjuikqeiecbhec
Executed in tipset: [bafy2bzacecbwmbw2pabgupmzv34fqmskszvgpsntzqvj7yq3xawukg6tjyfea]
Exit Code: 0
Gas Used: 107072567
Return: 0000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000582420064f5000000000000000000000000000000000000000000000000000000
ERROR: method 2 not found on actor bafk2bzacecvnas7szvqytqj2iwkl3zmhdc5snv7wj3emfrh64qefcgdclpcgo
```

You then can do the same for all the function in `build/CborTest.signatures`.

---

# Milestone 2: CBOR on Precompiles

## Abstract

This PoC attempt to use Ethereum precompiles concept to serialize/deserialize CBOR data so Filecoin actors can consume them. The objectif is to write precompile functions then to benchmark the gas consumption.

## How to

