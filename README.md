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

### windows
Download the latest nvim release, for example https://github.com/neovim/neovim/releases/download/v0.11.6/nvim-win64.zip
Move it to `C:\Users\<USERNAME>\bin\nvim-win64` and add this `C:\Users\<USERNAME>\bin\nvim-win64\bin` to path. 
Create folder: `C:\Users\JOBSO\AppData\Local\nvim` and copy config here, i. e. the `nvim` directory of this repo. 
Create folder `C:\Users\JOBSO\AppData\Local\nvim-data\lazy` and run this `git clone https://github.com/folke/lazy.nvim.git`. This is important, because lazy needs to be installed manually. 

This config need gcc. Download it from https://winlibs.com/#download-release, for example https://github.com/brechtsanders/winlibs_mingw/releases/download/15.2.0posix-13.0.0-ucrt-r5/winlibs-x86_64-posix-seh-gcc-15.2.0-mingw-w64ucrt-13.0.0-r5.7z
Move to `C:\Users\<USERNAME>\bin\mingw64\bin` and add to path. 







