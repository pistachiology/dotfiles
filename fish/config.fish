# Vim replace
function vim; nvim $argv; end
function vi; nvim $argv; end
alias oldvim="\vim"

source "$HOME/dotfiles/fish/theme.fish"
source "$HOME/dotfiles/fish/private.fish"
source "$HOME/dotfiles/fish/nnn.fish"

fish_vi_key_bindings

if test -e "$HOME/.asdf/asdf.fish"
	source "$HOME/.asdf/asdf.fish"
end

if type -q zoxide
    zoxide init fish | source
end

switch (uname) 
    case Linux
        source "$HOME/dotfiles/fish/linux.fish"
    case '*'
        echo
end

# Ruby
# status --is-interactive; and source (rbenv init - | psub)


# fzf
set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --ignore-case -g \'!.git\''
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -gx SKIM_DEFAULT_COMMAND "rg --files --ignore-case --hidden -g '!.git"

# set -gx FZF_DEFAULT_COMMAND  'rg --files --hidden'
# set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"


# Path

# Tmux
set ZSH_TMUX_AUTOSTART true
function ta; tmux attach -t $argv; end
function sclear ; clear; tmux clear-history; end


# Expose Term for SSH
function ssh
    TERM=screen-256color command ssh $argv
end
function gs ; git status --short --branch $argv; end

# Go(lang)
set GOPATH $HOME/go/
set -gx PATH $HOME/go/bin $HOME/bin /usr/local/go/bin $PATH 

# Rust
set -gx PATH $HOME/.cargo/bin $PATH
function ccw ; cargo check --workspace --all-targets $argv; end


# Python
set -gx PATH $PATH /Library/Frameworks/Python.framework/Versions/3.8/bin

# Java
# alias set_java11="set -x JAVA_HOME /Library/Java/JavaVirtualMachines/openjdk-11.0.2.jdk/Contents/Home/"
# set -x JAVA_HOME "/usr/local/Cellar/openjdk@11/11.0.9/libexec/openjdk.jdk/Contents/Home/"
#


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


# ~/.config/fish/functions/nvm.fish
function nvm
  # bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
end

# ~/.config/fish/functions/nvm_find_nvmrc.fish
function nvm_find_nvmrc
  # bass source ~/.nvm/nvm.sh --no-use ';' nvm_find_nvmrc
end

# ~/.config/fish/functions/load_nvm.fish
function load_nvm
  set -l default_node_version (nvm version default)
  set -l node_version (nvm version)
  set -l nvmrc_path (nvm_find_nvmrc)
  if test -n "$nvmrc_path"
    set -l nvmrc_node_version (nvm version (cat $nvmrc_path))
    if test "$nvmrc_node_version" = "N/A"
      nvm install $nvmrc_node_version
    else if test nvmrc_node_version != node_version
      nvm use $nvmrc_node_version
    end
  else if test "$node_version" != "$default_node_version"
    echo "Reverting to default Node version"
    nvm use default
  end
end


# status --is-interactive; and source (jump shell fish --bind=z | psub)

complete --command j --exclusive --arguments '(__jump_hint)'


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/pistachio/tools/google-cloud-sdk/path.fish.inc' ]; . '/Users/pistachio/tools/google-cloud-sdk/path.fish.inc'; end


set SBT_OPTS "-mem 8094"
