// SPDX-License-Identifier: MIT
pragma solidity >=0.4.25 <= 0.8.15;

contract Precompile {
    
    constructor() {}

    function test() public returns (uint[1] memory) {
        uint[1] memory result;

        assembly {
            // staticcall(gasLimit, to, inputOffset, inputSize, outputOffset, outputSize)
            // NOTES: 0x0a is the address of the precompile contract
            if iszero(staticcall(100000000, 0x0a, 0x00, 0x00, 0x00, 0x00)) {
                revert(0,0)
            }
        }

        return result;
    }

    function cborBoolean() public returns (uint[1] memory) {
        bool a = true;
        uint[1] memory result;

        assembly {
            let buf := mload(0x40)
            mstore(buf, a)

            // staticcall(gasLimit, to, inputOffset, inputSize, outputOffset, outputSize)
            // NOTES: 0x0b is the address for cbor_bool
            if iszero(staticcall(100000000, 0x0b, buf, 0x20, result, 0x20)) {
                revert(0,0)
            }
        }

        return result;
    }

    function subSha256() public returns (bytes32) {
        bytes memory data = hex"666F6F206261722062617A20626F7879";
        bytes32[1] memory result;
        assembly {
            pop(staticcall(100000000, 0x02, add(data, 0x20), 0x10, result, 0x20))
        }
        return result[0];
    }

    function cborAddress() public returns (bytes32) {
        //address a = address(0xFF000000000000000000000000000000000003E9);
        address a = msg.sender;
        bytes32[1] memory result;
        assembly {
            let buf := mload(0x40)
            mstore(buf, a)
            
            // we offset by 12 + 1 to remove the `ff`
            pop(staticcall(100000000, 0x0c, add(buf, 0x0d), 0x20, result, 0x20))
        }
        return result[0];
    }
}