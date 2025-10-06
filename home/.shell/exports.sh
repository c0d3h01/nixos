#!/usr/bin/env zsh

# Helper functions
add_to_path() { [[ -d "$1" && ":$PATH:" != *":$1:"* ]] && path=("$1" $path) }
ifsource() { [[ -f "$1" ]] && source "$1" }

# Rust
ifsource "$HOME/.local/share/cargo/env"
export RUSTFLAGS="-C link-arg=-fuse-ld=mold"
export CARGO_BUILD_JOBS=8
export CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_LINKER=clang

# Java
command -v mise &>/dev/null && export JAVA_HOME="$(mise where java 2>/dev/null)"

# Android
if [[ -d "$HOME/Android/Sdk" ]]; then
    export ANDROID_HOME="$HOME/Android/Sdk"
    export ANDROID_SDK_ROOT="$ANDROID_HOME"
    export NDK_HOME="$ANDROID_HOME/ndk"
    add_to_path "$ANDROID_HOME/platform-tools"
    add_to_path "$ANDROID_HOME/emulator"
    add_to_path "$ANDROID_HOME/build-tools/36.0.0"
    add_to_path "$NDK_HOME"
fi

# Flutter
if [[ -d "$HOME/Android/flutter" ]]; then
    export FLUTTER_HOME="$HOME/Android/flutter"
    export CHROME_EXECUTABLE="${commands[chromium]:-${commands[google-chrome]}}"
    add_to_path "$FLUTTER_HOME/bin"
    add_to_path "$HOME/.pub-cache/bin"
fi

# Go
export GOPATH="$HOME/.local/share/go"
export GOBIN="$GOPATH/bin"
add_to_path "$GOBIN"

# Python
export PYENV_ROOT="$HOME/.local/share/pyenv"
export WORKON_HOME="$HOME/.local/share/virtual-envs"
if [[ -d "$PYENV_ROOT" ]]; then
    add_to_path "$PYENV_ROOT/bin"
    eval "$(pyenv init --path 2>/dev/null)"
fi

# Node (lazy loaded)
export NVM_DIR="$HOME/.local/nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && nvm() {
    unfunction nvm
    source "$NVM_DIR/nvm.sh"
    [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
    nvm "$@"
}

# Other tools
add_to_path "$HOME/.deno/bin"
add_to_path "$HOME/.dotnet"
add_to_path "$HOME/.local/share/solana/install/active_release/bin"

# Nix
if [[ -d "$HOME/.nix-profile" ]]; then
    add_to_path "$HOME/.nix-profile/bin"
    export XDG_DATA_DIRS="$HOME/.nix-profile/share:/usr/share"
fi

# Local bins
add_to_path "$HOME/.local/bin"
for bin in random helpers utils backpocket git jj docker kubernetes music tmux ai; do
    add_to_path "$HOME/.local/bin/$bin"
done
add_to_path "$HOME/.npm-global/bin"
add_to_path "$HOME/bin"

# Tool configs
export TS_MAXFINISHED=13
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git --color=always'
export FZF_DEFAULT_OPTS='-0 --prompt=" " --inline-info --reverse --height "40%" --color fg:-1,hl:4,fg+:1,bg+:-1,hl+:4,info:108,prompt:242,spinner:108,pointer:1,marker:168'
export DOCKER_BUILDKIT=1
export DELVE_EDITOR=",emacs-no-wait"
export AIDER_GITIGNORE=false
export AIDER_CHECK_UPDATE=false
export K9S_CONFIG_DIR="$HOME/.config/k9s"

# Finalize
typeset -U path
export PATH