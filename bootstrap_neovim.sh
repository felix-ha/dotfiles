NVIM_VERSION="v0.10.4"

set -e 
apt update
apt install git curl fuse libfuse2 -y
git clone https://github.com/felix-ha/dotfiles.git ~/.dotfiles

curl -LO https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage
./nvim-linux-x86_64.appimage --appimage-extract
mv squashfs-root /opt/nvim
ln -s /opt/nvim/usr/bin/nvim /usr/local/bin/nvim

apt install git make g++ ripgrep -y
[[ -d ~/.config ]] || mkdir ~/.config
ln -s ~/.dotfiles/nvim ~/.config/nvim
echo 'alias v="nvim"' >> ~/.bashrc
