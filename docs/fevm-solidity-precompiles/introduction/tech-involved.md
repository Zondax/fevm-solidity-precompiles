---
title: "Technologies Involved"
sidebar_position: 2
---
These technologies are closely related to the FEVM PoC project, so it is important for you to understand what they are about.

### What is Solidity?
Solidity is an object-oriented, high-level language for implementing smart contracts. Smart contracts are programs which govern the behaviour of accounts within the Ethereum state.

Solidity is statically typed, supports inheritance, libraries and complex user-defined types among other features.

With Solidity you can create contracts for uses such as voting, crowdfunding, blind auctions, and multi-signature wallets.

For more information, please refer to the [Solidity web page](https://docs.soliditylang.org/en/v0.8.16/).

### What is CBOR?

Concise Binary Object Representation (CBOR) is a binary data serialization format loosely based on JSON authored by C. Bormann. Like JSON it allows the transmission of data objects that contain name–value pairs, but in a more concise manner. This increases processing and transfer speeds at the cost of human readability

For more information, please refer to the [Wikipedia article](https://en.wikipedia.org/wiki/CBOR).

### What is precompile?

In Ethereum, it is possible to call some specific function at a dedicated address. They are called precompiles contracts. They are contracts bundle with the Ethereum Virtual Machine.

For more information, please refer to the [EVM Precompiled Contracts page](https://www.evm.codes/precompiled?fork=merge).

Similar to Ethereum, FEVM have its own set of precompiled contracts that can be call the same way you would do with Solidity. It offers a fixed gas cost for what would be expensive operations natively.

