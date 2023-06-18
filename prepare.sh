echo "\033[43;31mInstall go-quorum\033[0m"
git clone https://github.com/ConsenSys/quorum.git
echo "\033[43;31mPetacle using go-quorum v23.4.0\033[0m"
cd quorum && git checkout tags/v23.4.0
echo "\033[43;31mBuild go-quorum...\033[0m"
path='$PATH:'
script_path=$(cd "$(dirname "$0")" && pwd)
bin_path="$script_path/build/bin"
make all 


echo "\033[43;31m[INFO] To continue using the geth command, use export PATH="$path$bin_path" Must be added to ~/.bashrc or ~/.zshrc.\033[0m"