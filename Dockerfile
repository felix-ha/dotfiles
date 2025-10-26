FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
    curl \
    # vim \
    # tmux \
    # nodejs \
    # npm \
    && rm -rf /var/lib/apt/lists/*

# RUN bash -c "$(curl -fsSL https://raw.githubusercontent.com/felix-ha/dotfiles/main/bootstrap_neovim.sh)"
#
# RUN curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to /usr/local/bin
#
# RUN curl -LsSf https://astral.sh/uv/install.sh | sh

RUN curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | \
    BOOTSTRAP_HASKELL_NONINTERACTIVE=1 \
    BOOTSTRAP_HASKELL_INSTALL_HLS=1 \
    sh
#
# RUN npm i -g @openai/codex

