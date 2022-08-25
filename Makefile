build: build_cbor build_example

build_example:
	solc contract/simplecoin.sol --output-dir ./build --overwrite --bin

build_cbor:
	solc contract/cbor_test.sol --output-dir ./build --overwrite --bin
