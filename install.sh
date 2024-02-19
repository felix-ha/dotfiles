git clone https://github.com/felix-ha/dotfiles.git ~/.dotfiles

apt update

# neovim
# apt install neovim -y
apt install libfuse2 ripgrep fd-find g++ npm -y
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
mv squashfs-root /
ln -s /squashfs-root/AppRun /usr/bin/nvim

if [[ -d ~/.config ]]; then
    echo "~/.config exists"
else
    echo "creating dir ~/.config"
    mkdir ~/.config
fi

ln -s ~/.dotfiles/nvim ~/.config/nvim
