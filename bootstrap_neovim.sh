NVIM_VERSION="v0.10.4"

set -e 
apt update
apt install git curl -y
git clone https://github.com/felix-ha/dotfiles.git ~/.dotfiles

curl -LO https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-x86_64.tar.gz
tar xzvf nvim-linux-x86_64.tar.gz
mv nvim-linux-x86_64 /opt/nvim
ln -s /opt/nvim/bin/nvim /usr/local/bin/nvim

apt install git make g++ ripgrep -y
[[ -d ~/.config ]] || mkdir ~/.config
ln -s ~/.dotfiles/nvim ~/.config/nvim
echo 'alias v="nvim"' >> ~/.bashrc
