---
title: "Conclusions"
sidebar_position: 5
---

FEVM contracts support in Filecoin allows solidity developpers to test their contract on Filecoin. However it currently uses a significant amount of gas which can be an issue for production. The Filecoin dev team is dedicated to optimize the cost of FEVM contract to offer the best experience to Filecoin users and developpers.

Alternatively, Zondax has developped an (AssemblyScript SDK)[https://github.com/Zondax/fvm-as-sdk/] which use a syntax similar to Javascript/Solidity. Gas consumption is lower when calling actors (aka smart contracts) that have been compiled to WASM. It offers better performances but still requires re-writting the contract.