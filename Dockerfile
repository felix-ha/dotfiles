FROM ubuntu:24.04 AS builder

SHELL ["/bin/bash", "-c"]

ENV NVIM_VERSION="v0.10.4"

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    # Git to clone
    git \
    # Neovim build dependencies
    build-essential \
    cmake \
    g++ \
    libtool-bin \
    gettext \
    libffi-dev \
    libgmp-dev \
    libncurses-dev \
    pkg-config \
    # Clean up
    && rm -rf /var/lib/apt/lists/*

RUN set -e; \
    git clone https://github.com/neovim/neovim.git; \
    cd neovim; \
    git checkout $NVIM_VERSION; \
    make CMAKE_BUILD_TYPE=RelWithDebInfo; \
    make install; \
    cd ..; \
    rm -rf neovim

FROM ubuntu:24.04

SHELL ["/bin/bash", "-c"]

ENV SHELL /bin/bash

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    # General tools
    curl \
    git \
    vim \
    tmux \
    nodejs \
    npm \
    luarocks \
    # Runtime libs for Neovim (installed by build-deps in stage 1)
    libffi8 \
    libgmp10 \
    libncurses6 \
    gettext \
    zlib1g-dev \
    # Neovim plugin dependencies
    ripgrep \
    fd-find \
    # Clean up
    && rm -rf /var/lib/apt/lists/*

RUN ln -s $(which fdfind) /usr/local/bin/fd

COPY --from=builder /usr/local /usr/local

RUN curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to /usr/local/bin

RUN curl -LsSf https://astral.sh/uv/install.sh | sh

RUN curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | \
    BOOTSTRAP_HASKELL_NONINTERACTIVE=1 \
    BOOTSTRAP_HASKELL_INSTALL_HLS=1 \
    sh
    
ENV PATH="/root/.ghcup/bin:$PATH"

RUN npm i -g @openai/codex && npm cache clean --force

RUN set -e; \
    git clone https://github.com/felix-ha/dotfiles.git ~/.dotfiles; \
    [[ -d ~/.config ]] || mkdir ~/.config; \
    ln -s ~/.dotfiles/nvim ~/.config/nvim; \
    echo 'alias v="nvim"' >> ~/.bashrc

RUN nvim --headless "+Lazy! sync" +qa

WORKDIR /host

CMD ["/bin/bash"]
