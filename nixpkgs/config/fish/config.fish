fish_vi_key_bindings

# envrc
if type -q direnv
    eval (direnv hook fish)
end

switch (uname) 
    case Linux
        if test -e "$HOME/.config/nixpkgs/config/fish/linux.fish"
            source "$HOME/.config/nixpkgs/config/fish/linux.fish"
        end

    case '*'
end

# fzf
set -gx FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow -g "!{.git,node_modules,vendor}/*" '
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

function sclear ; clear; tmux clear-history; end
function ssh ; TERM=screen-256color command ssh $argv; end
function gs ; git status --short --branch $argv; end
function ccw ; cargo check --workspace --all-targets $argv; end
function with-proxy
    http_proxy=http://127.0.0.1:9090 https_proxy=http://127.0.0.1:9090 $argv
end

set -x GPG_TTY (tty)
set -gx EDITOR "nvim"

# Go(lang)
# set GOPATH $HOME/go/
# set -gx PATH $HOME/go/bin $HOME/bin /usr/local/go/bin $PATH 

# Rust
# set -gx PATH $HOME/.cargo/bin $PATH
# set -gx PATH $PATH $HOME/.local/bin

