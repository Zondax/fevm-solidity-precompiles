build: build_precompile

build_precompile:
	./bin/solc contract/precompile.sol --output-dir ./build --overwrite --bin --hashes --opcodes
	xxd -r -p build/Precompile.bin build/Precompile.bin

install_solc_linux:
	wget https://binaries.soliditylang.org/linux-amd64/solc-linux-amd64-v0.8.15+commit.e14f2714
	mv solc-linux-amd64-v0.8.15+commit.e14f2714 bin/solc
	chmod +x bin/solc

install_solc_win:
	@echo "No Windows. Only Linux."

install_solc_mac:
	@echo "No macOS. Only Linux."

install-llvm-ci:
	echo 'deb http://apt.llvm.org/focal/ llvm-toolchain-focal-13 main' | sudo tee /etc/apt/sources.list.d/llvm.list
	wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -
	sudo apt-get update
	sudo apt-get install clang-13 llvm-13-dev lld-13 libclang-13-dev
