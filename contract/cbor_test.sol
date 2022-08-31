// SPDX-License-Identifier: MIT
pragma solidity >=0.4.25 <= 0.8.16;

contract CborTest {

    constructor() {}

    // serialize() --> Keccak-256 --> first 4 bytes --> bc8018b1
    function serialize() public returns(string memory result) {
        return "";
    }

    // deserialize() --> Keccak-256 --> first 4 bytes --> b5cc88f3
    function deserialize() public returns(bool valid) {
        return true;
    }

    // serializeAddress(address) --> Keccak-256 --> first 4 bytes --> 241d23b2
    function serializeAddress(address addr) public returns(bytes memory result) {
        bytes memory res_ = abi.encodePacked(addr);

        // calculate length
        uint8 l = 0;
        for (uint i = 0; i < res_.length; i++) {
            if (res_[i] != 0) {
                l = uint8(res_.length - i);
                break;
            } 
        }

        bytes memory tmp = new bytes(l+2);
        uint offset = 0;
        // cbor bytes
        if (l < 24) {
            uint8 v = (2 << 5 | l);
            tmp[0] = bytes1(v);
            offset = 1;
        } else {
            uint8 v = (2 << 5 | 24);
            tmp[0] = bytes1(v);
            tmp[1] = bytes1(l);
            offset = 2;
        }

        for (uint i = l; i < res_.length; i++) {
            tmp[offset+i] = res_[i];
        }

        return abi.encodePacked(res_);
    }
}
