apt update

# zsh
apt install zsh -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
ln -s -f ~/.dotfiles/.zshrc ~/.zshrc

# neovim
# apt install neovim -y
apt install libfuse2 ripgrep -y
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
mv squashfs-root /
ln -s /squashfs-root/AppRun /usr/bin/nvim
mkdir ~/.config
ln -s ~/.dotfiles/nvim ~/.config/nvim

alias vim="nvim"
alias vi="nvim"
alias v="nvim"


bash -c  "$(curl -fsSL https://raw.githubusercontent.com/officialrajdeepsingh/nerd-fonts-installer/main/install.sh JetBrainsMono)" 