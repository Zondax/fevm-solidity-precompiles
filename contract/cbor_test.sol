// SPDX-License-Identifier: MIT
pragma solidity >=0.4.25 <= 0.8.16;

contract CborTest {

    constructor() {}

    // serialize() --> Keccak-256 --> first 4 bytes --> bc8018b1
    function serialize() public pure returns(string memory result) {
        return "";
    }

    // deserialize() --> Keccak-256 --> first 4 bytes --> b5cc88f3
    function deserialize() public pure returns(bool valid) {
        return true;
    }

    // serializeAddress(address) --> Keccak-256 --> first 4 bytes --> 241d23b2
    // 0000000000000000000000000000000000000000000000000000000000000064 <-- ID address (t0100) | (64)hex -> (100)decimal

    // result
    // 0000000000000000000000000000000000000000000000000000000000000020 <-- offset (32 bytes)
    // 0000000000000000000000000000000000000000000000000000000000000004 <-- length (32 bytes)
    // 4200640000000000000000000000000000000000000000000000000000000000 <-- data[0] (32 bytes but only the 4 first matters)
    function serializeAddress(address addr) public pure returns(bytes memory result) {
        bytes memory res_ = abi.encodePacked(addr);

        // calculate length (maybe reverse ?)
        uint8 l = 0;
        for (uint i = 0; i < res_.length; i++) {
            if (res_[i] != 0) {
                l = uint8(res_.length - i);
                break;
            } 
        }
        // l += 1;

        // add protocol byte so length is +1 and 2 bytes max for cbor size
        bytes memory tmp;
        uint offset = 0;
        // cbor bytes
        if (l < 24) {
            tmp = new bytes(l+2);
            uint8 v = (2 << 5 | (l+1));
            tmp[0] = bytes1(v);
            offset = 1;
        } else {
            tmp = new bytes(l+3);
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

    function serializeBool(bool value) public pure returns(bytes memory result) {
        if (value) { return serializeTrue(); }
       
       return serializeFalse();
    }

    function serializeTrue() private pure returns(bytes memory result) {
        bytes memory res = new bytes(1);
        res[0] = 0xf5;

        return res;
    }

    function serializeFalse() private pure returns(bytes memory result) {
        bytes memory res = new bytes(1);
        res[0] = 0xf4;

        return res;
    }

    function serializeAddSigner(address signer, bool increase) public pure returns(bytes memory result) {
        bytes memory signerCBOR = serializeAddress(signer);
        bytes memory increaseCBOR = serializeBool(increase);

        bytes memory res = new bytes(1);
        uint8 v = (4 << 5 | 2); // 2 elements in array
        res[0] = bytes1(v);
        
        bytes memory res2 = bytes.concat(res, signerCBOR);
        bytes memory res3 = bytes.concat(res2, increaseCBOR);

        return res3;
    }
}