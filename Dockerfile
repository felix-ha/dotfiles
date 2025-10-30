FROM ubuntu:24.04

SHELL ["/bin/bash", "-c"]

ENV NVIM_VERSION="v0.10.4"
ENV SHELL /bin/bash

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    # general
    curl \
    git \
    vim \
    tmux \
    nodejs \
    npm \
    luarocks \
    # ghcup
    build-essential \
    libffi-dev \
    libffi8 \
    libgmp-dev \
    libgmp10 \
    libncurses-dev \
    pkg-config \
    # neovim build from source
    g++ \
    ripgrep \
    fd-find \
    cmake \
    libtool-bin \
    gettext \
    # Clean up apt cache
    && rm -rf /var/lib/apt/lists/*

RUN set -e; \
    git clone https://github.com/neovim/neovim.git; \
    cd neovim; \
    git checkout $NVIM_VERSION; \
    make CMAKE_BUILD_TYPE=RelWithDebInfo; \
    make install; \
    cd ..; \
    rm -rf neovim

RUN curl --proto '=httpsS' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to /usr/local/bin

RUN curl -LsSf https://astral.sh/uv/install.sh | sh

RUN curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | \
    BOOTSTRAP_HASKELL_NONINTERACTIVE=1 \
    BOOTSTRAP_HASKELL_INSTALL_HLS=1 \
    sh
    
ENV PATH="/root/.ghcup/bin:$PATH"

RUN npm i -g @openai/codex

RUN set -e; \
    git clone https://github.com/felix-ha/dotfiles.git ~/.dotfiles; \
    [[ -d ~/.config ]] || mkdir ~/.config; \
    ln -s ~/.dotfiles/nvim ~/.config/nvim; \
    echo 'alias v="nvim"' >> ~/.bashrc

RUN nvim --headless "+Lazy! sync" +qa

WORKDIR /

CMD ["/bin/bash"]

