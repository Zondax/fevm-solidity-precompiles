// SPDX-License-Identifier: MIT
pragma solidity >=0.4.25 <= 0.8.16;

contract CborTest {

    constructor() {}

    // serialize() --> Keccak-256 --> first 4 bytes --> bc8018b1
    function serialize() public returns(string result) {
        return "";
    }

    // deserialize() --> Keccak-256 --> first 4 bytes --> b5cc88f3
    function deserialize() public returns(bool valid) {
        return true;
    }

}
