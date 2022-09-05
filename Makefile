build: build_cbor build_example

build_example:
	./bin/solc contract/simplecoin.sol --output-dir ./build --overwrite --bin --hashes
	xxd -r -p build/SimpleCoin.bin build/SimpleCoin.bin

build_cbor:
	./bin/solc contract/cbor_test.sol --output-dir ./build --overwrite --bin --hashes
	xxd -r -p build/CborTest.bin build/CborTest.bin

install_solc_linux:
	wget https://binaries.soliditylang.org/linux-amd64/solc-linux-amd64-v0.8.15+commit.e14f2714
	mv solc-linux-amd64-v0.8.15+commit.e14f2714 bin/solc
	chmod +x bin/solc

install_solc_win:
	@echo "No Windows. Only Linux."

install_solc_mac:
	@echo "No macOS. Only Linux."