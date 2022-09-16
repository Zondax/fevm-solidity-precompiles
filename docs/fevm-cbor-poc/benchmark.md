---
title: "Benchmarks"
sidebar_position: 4
---

## Original benchmark (before FEVM optimization)

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

This benchmark compares gas used for CBOR serialization written in solidity with other calls like a simple transfer of FIL or a ERC20 transfer call written using (assemblyscript SDK developped by Zondax)[https://github.com/Zondax/fvm-as-sdk/].

## Benchmark Selenium

This benchmark shows the progression after FEVM optimizations.

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

## Benchmark Copper

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