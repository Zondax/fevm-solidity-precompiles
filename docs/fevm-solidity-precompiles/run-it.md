---
title: How to reproduce the results?
sidebar_position: 4
---


## Milestone 1

### Install deps
You should choose the command depending on your OS
```
make install_solc_mac
```
or 
```
make install_solc_linux
```

### Build
It is as simple as run the following command. It will compile solidity smart contracts and leave them on `bin` folder.
```
make build
```

### Run
It is as simple as run the following command. It will compile a rust project which uses the integration crate created by filecoin. 
```
make test
```

### Notes
#### Running on lotus node
Here you will find an example that shows how to install and run the compiled smart contract on real lotus node.

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

## Milestone 2

### Install deps
You should choose the command depending on your OS
```
make install_solc_mac
```
or
```
make install_solc_linux
```

### Build
It is as simple as run the following command. It will compile solidity smart contracts and leave them on `bin` folder.
```
make build
```

### Run
It is as simple as run the following command. It will compile a rust project which uses the integration crate created by filecoin.
```
make test
```
