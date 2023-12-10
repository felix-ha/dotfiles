git clone https://github.com/felix-ha/dotfiles.git ~/.dotfiles

apt update

# neovim
# apt install neovim -y
apt install libfuse2 ripgrep fd-find -y
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
mv squashfs-root /
ln -s /squashfs-root/AppRun /usr/bin/nvim
mkdir ~/.config
ln -s ~/.dotfiles/nvim ~/.config/nvim
