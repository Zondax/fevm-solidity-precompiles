---
title: "Solidity libraries and pre-compiles for FEVM"
sidebar_position: 1
---

:::info The following project has been funded by the [Filecoin Foundation](https://fil.org).

<img src={require('../assets/fil_foundation.png').default} alt="drawing" width="300" />

:::



In the context of the FVM Early Builder program (Solidity edition), we proposee to build a set of tools and libraries to enable Ethereum developers to re-use their existing know-how to develop Filecoin-specific use cases.

### Milestone 1: CBOR Serialization on Solidity

The first goal consisted of a feasibility analysis to evaluate if it is worth it to serialise and deserialize data in solidity.

### Milestone 2: CBOR Serialization on Precompiles

In this case, we analyse a different approach which consisted in using precompiled contracts to serialize and deserialize data in solidity.

