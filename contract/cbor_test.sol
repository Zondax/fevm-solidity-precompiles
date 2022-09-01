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

    
    function encodeUnsignedLeb128FromUInt64(uint64 v) private returns(bytes memory result) {
    bytes memory result = new bytes(32);
    uint offset = 0;
        while (true) {
            uint64 byte_ = v & 0x7f;
            v = v >> 7;
            if (v == 0) {
                result[offset] = bytes1(uint8(byte_));
                return result;
            }
            result[offset] = bytes1(uint8(byte_ | 0x80));
            offset = offset + 1;
        }
    }

    // serializeAddress(address) --> Keccak-256 --> first 4 bytes --> 241d23b2
    // 0000000000000000000000000000000000000000000000000000000000000064 <-- ID address

    // result
    // 0000000000000000000000000000000000000000000000000000000000000020 <-- offset (32 bytes)
    // 0000000000000000000000000000000000000000000000000000000000000004 <-- length (32 bytes)
    // 4200640000000000000000000000000000000000000000000000000000000000 <-- data[0] (32 bytes but only the 4 first matters)
    function serializeAddress(address addr) public returns(bytes memory result) {
        //bytes memory res_ = encodeUnsignedLeb128FromUInt64(uint64(uint160(addr)));
        bytes memory res_ = abi.encodePacked(addr);

        // calculate length
        uint8 l = 0;
        for (uint i = 0; i < res_.length; i++) {
            if (res_[i] != 0) {
                l = uint8(res_.length - i);
                break;
            } 
        }
        // l += 1;

        // add protocol byte so length is +1 and 2 bytes max for cbor size
        bytes memory tmp = new bytes(l+3);
        uint offset = 0;
        // cbor bytes
        if (l < 24) {
            uint8 v = (2 << 5 | (l+1));
            tmp[0] = bytes1(v);
            offset = 1;
        } else {
            uint8 v = (2 << 5 | 24);
            tmp[0] = bytes1(v);
            tmp[1] = bytes1(l+1);
            offset = 2;
        }

        tmp[offset] = bytes1(0); // ID address it protocol 0
        offset += 1;

        for (uint i = (res_.length - l); i < res_.length; i++) {
            tmp[offset] = res_[i];
            offset += 1;
        }

        return tmp;
    }
}