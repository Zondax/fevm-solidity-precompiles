---
title: "Conclusions"
sidebar_position: 6
---

## Milestone 1

FEVM contracts support in Filecoin allows solidity developers to test their contract on Filecoin. However, it currently uses a significant amount of gas which can be an issue for production. The Filecoin dev team is dedicated to optimize the cost of FEVM contract to offer the best experience to Filecoin users and developers.

Alternatively, Zondax has developed an [AssemblyScript SDK](https://github.com/Zondax/fvm-as-sdk/) which use a syntax similar to Javascript/Solidity. Gas consumption is lower when calling actors (aka smart contracts) that have been compiled to WASM. It offers better performances but still requires re-writing the contract.

## Milestone 2
In Milestone 1, we explored how to serialize and deserialize data in CBOR in a Solidity contract. We noticed a huge gas consumption and even after FEVM optimization the gas used was still significantly more than native contracts. This will impact negatively the user experience when interacting with Solidity based actor.

In this new proof of concept, we have been using precompiled contract that are bundle inside teh EVM actor. It allows to significantly reduce the operations cost has we can give a fixed cost. However, it still uses in average **3.5** more gas when compared to the gas usage of a WASM actor. We believe that it is the memory usage to interact with the precompiled contracts that consume the most gas.
