NVIM_VERSION="v0.10.4"

set -e 

apt update && apt install -y git cmake g++ pkg-config libtool-bin gettext
git clone https://github.com/neovim/neovim.git
cd neovim && git checkout $NVIM_VERSION
make CMAKE_BUILD_TYPE=RelWithDebInfo
make install
cd ..
rm -rf neovim

git clone https://github.com/felix-ha/dotfiles.git ~/.dotfiles

apt install g++ ripgrep fd-find -y

[[ -d ~/.config ]] || mkdir ~/.config
ln -s ~/.dotfiles/nvim ~/.config/nvim
echo 'alias v="nvim"' >> ~/.bashrc
