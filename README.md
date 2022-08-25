# FEVM CBOR PoC

## Related documentation

### Entry point for calling function
Please, read this [doc](https://docs.soliditylang.org/en/v0.8.16/abi-spec.html#function-selector)

Example: 

```solidity
        // sendCoin(address,uint) --> Keccak-256 --> first 4 bytes --> 38f633e9
        function sendCoin(address receiver, uint amount) public returns(bool sufficient) {
                if (balances[msg.sender] < amount) return false;
                balances[msg.sender] -= amount;
                balances[receiver] += amount;
                emit Transfer(msg.sender, receiver, amount);
                return true;
        }
```
