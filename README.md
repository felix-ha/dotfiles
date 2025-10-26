# dotfiles

My personal dotfiles.

## Run dev-shell
```bash
docker run -it -v "$(pwd):/host" ghcr.io/felix-ha/dev-shell:main bash
```

Or set alias in `.bashrc`
```bash
alias dev-shell='docker run -it -v "$(pwd):/host" ghcr.io/felix-ha/dev-shell:main bash'
```
## neovim config
### install neovim
Bootstrap bash script that creates smylinks - intended for linux
```bash
bash -c  "$(curl -fsSL https://raw.githubusercontent.com/felix-ha/dotfiles/main/bootstrap_neovim.sh)" 
```

### custom config
Start neovim with custom config in directory `$HOME/.config/custom`
```bash
NVIM_APPNAME=custom nvim
```

Copy custom config to dotfiles repo 
```bash
cp -r custom/ $HOME/repositories/priv/dotfiles/nvim/
```

