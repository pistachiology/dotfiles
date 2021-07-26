# Vim replace
function vim; nvim $argv; end
function vi; nvim $argv; end

source "$HOME/dotfiles/fish/theme.fish"
source "$HOME/dotfiles/fish/private.fish"

fish_vi_key_bindings

if test -e "$HOME/.asdf/asdf.fish"
	source "$HOME/.asdf/asdf.fish"
else if test -e "/usr/local/opt/asdf/asdf.fish"
    # for mac os install with homebrew
    source /usr/local/opt/asdf/asdf.fish
end

if type -q zoxide
    zoxide init fish | source
end

if type -q just
    just --completions fish | source
    function j; just $argv; end
end

switch (uname) 
    case Linux
        source "$HOME/dotfiles/fish/linux.fish"
    case '*'
end

# fzf
set -gx FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow -g "!{.git,node_modules,vendor}/*" '
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"


# Tmux
function sclear ; clear; tmux clear-history; end


# Expose Term for SSH
function ssh
    TERM=screen-256color command ssh $argv
end

function gs ; git status --short --branch $argv; end

function with-proxy
    http_proxy=http://127.0.0.1:9090 https_proxy=http://127.0.0.1:9090 $argv
end

# Go(lang)
set GOPATH $HOME/go/
set -gx PATH $HOME/go/bin $HOME/bin /usr/local/go/bin $PATH 

# Rust
set -gx PATH $HOME/.cargo/bin $PATH
function ccw ; cargo check --workspace --all-targets $argv; end

# Python
set -gx PATH $PATH /Library/Frameworks/Python.framework/Versions/3.8/bin

set -x GPG_TTY (tty)

set -gx EDITOR "nvim"

# set -g fish_user_paths "/usr/local/opt/icu4c/bin" $fish_user_paths
# set -g fish_user_paths "/usr/local/opt/icu4c/sbin" $fish_user_paths
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths


# zlib
set -gx LDFLAGS "-L /usr/local/opt/zlib/lib -L/usr/local/opt/libffi/lib"  
set -gx CPPFLAGS "-I /usr/local/opt/zlib/include"
set -gx PKG_CONFIG_PATH "/usr/local/opt/zlib/lib/pkgconfig"

# Android
set -gx ANDROID_HOME $HOME/Library/Android/sdk
set -gx PATH $PATH $ANDROID_HOME/emulator
set -gx PATH $PATH $ANDROID_HOME/tools
set -gx PATH $PATH $ANDROID_HOME/tools/bin
set -gx PATH $PATH ANDROID_HOME/platform-tools


# envrc
eval (direnv hook fish)

# enable tools
function enable_jmeter_bin
    set -gx PATH $PATH $HOME/tools/jmeter-5.2.1/bin
end

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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/pistachio/tools/google-cloud-sdk/path.fish.inc' ]; . '/Users/pistachio/tools/google-cloud-sdk/path.fish.inc'; end

set SBT_OPTS "-mem 8094"

