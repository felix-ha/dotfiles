set -e 

apt update

apt install git -y

git clone https://github.com/felix-ha/dotfiles.git ~/.dotfiles

# neovim
# apt installs neovim version 0.9.5 at the time of writing this
# apt install neovim -y 

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
mv squashfs-root /
ln -s /squashfs-root/AppRun /usr/bin/nvim

#apt install software-properties-common -y
#add-apt-repository ppa:neovim-ppa/unstable -y
#apt update
#apt install neovim -y

apt install git make g++ ripgrep -y

if [[ -d ~/.config ]]; then
    echo "~/.config exists"
else
    echo "creating dir ~/.config"
    mkdir ~/.config
fi

ln -s ~/.dotfiles/nvim ~/.config/nvim

echo 'alias v="nvim"' >> ~/.bashrc
