# Vim replace
alias vim="nvim"
alias vi="nvim"
alias oldvim="\vim"

# Ruby
status --is-interactive; and . (rbenv init -|psub)

# [ -f ~/.fzf.zsh ]; and source ~/.fzf.zsh

# fzf
set FZF_DEFAULT_COMMAND 'rg --files --ignore-case'


# Path
set -gx PATH $PATH $HOME/tools/arcanist/bin

# Tmux
set ZSH_TMUX_AUTOSTART true
alias ta="tmux attach -t" 
alias tm="tmux"


# Expose Term for SSH
alias ssh="env TERM=xterm-256color ssh"

alias gs="git status --short --branch"

alias j="jump"
alias ja="mark"
alias jd="unmark"
alias js="marks" # show

set -gx FZF_DEFAULT_COMMAND "fd --type file"
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"


# Go(lang)
set GOPATH $HOME/go/
set -gx PATH $HOME/go/bin $HOME/bin /usr/local/go/bin $PATH 

# Rust
source $HOME/.cargo/env
set -gx PATH $HOME/.cargo/bin $PATH

set -x GPG_TTY (tty)

set -gx EDITOR "nvim"
set -g fish_user_paths "/usr/local/opt/icu4c/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/icu4c/sbin" $fish_user_paths
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/pistachio/Downloads/google-cloud-sdk/path.fish.inc' ]; . '/Users/pistachio/Downloads/google-cloud-sdk/path.fish.inc'; end



# zlib
set -gx LDFLAGS "-L /usr/local/opt/zlib/lib"
set -gx CPPFLAGS "-I /usr/local/opt/zlib/include"

set -gx PKG_CONFIG_PATH "/usr/local/opt/zlib/lib/pkgconfig"


# Sneak Google Cloud
alias cloud_proxy_sneak_blog="cloud_sql_proxy -dir=/cloudsql -instances=\"sneak-tmp:asia-east2:sneak-blog-tmp\""


# set -gx SUMO_HOME "$HOME/sumo_binaries/bin"
set -gx SUMO_HOME "/usr/local/opt/sumo/share/sumo"
set -gx PATH "$SUMO_HOME:$PATH"
