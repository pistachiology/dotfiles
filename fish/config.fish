# Vim replace
alias vim="nvim"
alias vi="nvim"
alias oldvim="\vim"

source "$HOME/.config/fish/theme.fish"

# Ruby
status --is-interactive; and source (rbenv init - | psub)


# fzf
set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --ignore-case -g \'!.git\''
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -gx SKIM_DEFAULT_COMMAND "rg --files --ignore-case --hidden -g '!.git"

# set -gx FZF_DEFAULT_COMMAND  'rg --files --hidden'
# set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"


# Path

# Tmux
set ZSH_TMUX_AUTOSTART true
alias ta="tmux attach -t" 
alias tm="tmux"
alias sclear="clear; tmux clear-history"


# Expose Term for SSH
alias ssh="env TERM=xterm-256color ssh"
alias gs="git status --short --branch"

alias j="jump"
alias ja="mark"
alias jd="unmark"
alias js="marks" # show

# Go(lang)
set GOPATH $HOME/go/
set -gx PATH $HOME/go/bin $HOME/bin /usr/local/go/bin $PATH 

# Rust
source $HOME/.cargo/env
set -gx PATH $HOME/.cargo/bin $PATH

set -x GPG_TTY (tty)

set -gx EDITOR "nvim"
# set -g fish_user_paths "/usr/local/opt/icu4c/bin" $fish_user_paths
# set -g fish_user_paths "/usr/local/opt/icu4c/sbin" $fish_user_paths
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/pistachio/Downloads/google-cloud-sdk/path.fish.inc' ]; . '/Users/pistachio/Downloads/google-cloud-sdk/path.fish.inc'; end


# zlib
set -gx LDFLAGS "-L /usr/local/opt/zlib/lib -L/usr/local/opt/libffi/lib"  
set -gx CPPFLAGS "-I /usr/local/opt/zlib/include"
set -gx PKG_CONFIG_PATH "/usr/local/opt/zlib/lib/pkgconfig"


function fish_mode_prompt --description 'Displays the current mode'
    if test "$fish_key_bindings" = "fish_vi_key_bindings"
        switch $fish_bind_mode
        case default
            set_color --bold red
            echo 🅽
        case insert
            set_color --bold green
            echo 🅸
        case replace-one
            set_color --bold green
            echo 🆁
        case visual
            set_color --bold brmagenta
            echo 🆅
        end
        set_color normal
        printf " "
    end
end
