# dotfiles

My personal dotfiles, but basically just my neovim config.

## Install
Bootstrap bash script that creates smylinks - intended for linux
```bash
bash -c  "$(curl -fsSL https://raw.githubusercontent.com/felix-ha/dotfiles/main/bootstrap_neovim.sh)" 
```

## Custom config
Start neovim with custom config in directory `$HOME/.config/custom`
```bash
NVIM_APPNAME=custom nvim
```

Copy custom config to dotfiles repo 
```bash
cp -r custom/ $HOME/repositories/priv/dotfiles/nvim/
```

