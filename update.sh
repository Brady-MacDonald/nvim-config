echo "Updating nvim version..."
echo "---------------------------"

nvim_version=$(nvim -v)

cd ~/source/neovim
git pull
make distclean
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

echo "---------↓↓↓Previous↓↓↓----------"
echo ${nvim_version}
echo $(nvim -v)
echo "---------↑↑↑Current↑↑↑----------"
