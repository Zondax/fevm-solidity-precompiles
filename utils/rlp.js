const rlp = require('rlp')

// https://gist.github.com/miguelmota/9099b705cf433336036065ab748c8404
const decoded_test = rlp.decode("0xed8205fc843b9aca00825208944592d8f8d7b001e72cb26a73e4fa1806a51ac79d88016345785d8a000080808080")
console.log(decoded_test)

// Arguments for example contract method on CI
const decoded_simplecoin = rlp.decode("0xf8b2cb4f")
console.log(decoded_simplecoin)

