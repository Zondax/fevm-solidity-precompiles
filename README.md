# FEVM CBOR PoC
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![GithubActions](https://github.com/Zondax/fevm-cbor-poc/actions/workflows/main.yaml/badge.svg)](https://github.com/Zondax/fevm-cbor-poc/blob/master/.github/workflows/main.yaml)

---

![zondax_light](docs/assets/zondax_light.png#gh-light-mode-only)
![zondax_dark](docs/assets/zondax_dark.png#gh-dark-mode-only)

_Please visit our website at [zondax.ch](https://www.zondax.ch)_

---

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

## Benchmarking

### Serializing an address compare to a send message

serializeAddress : 82006530
simple send tx: 413868

We have +19814% gas use compare to a simple send transaction when serializing address from address to cbor format.
