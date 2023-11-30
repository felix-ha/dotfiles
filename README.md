

## Setup zsh in wsl
sudo apt install zsh -y
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

make smbolic link
```zsh
ln -s ~/.dotfiles/.zshrc ~/.zshrc
```

```zsh
ln -s ~/.dotfiles/nvim/init.vim ~/.config/nvim/init.vim
```




