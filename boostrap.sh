#!/bin/sh

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

function link() {
    echo "linking file"
    
    ln -sv ${DIR}/gitconfig $HOME/.gitconfig
    ln -sv ${DIR}/tmux.conf $HOME/.tmux.conf
    ln -sv ${DIR}/tmux 	    $HOME/.tmux

    mkdir -p $HOME/.config
    ln -sv ${DIR}/nvim      	   $HOME/.config/nvim
    ln -sv ${DIR}/fish/config.fish $HOME/.config/fish/config.fish
    ln -sv ${DIR}/fish/kubectl_aliases $HOME/.config/fish/kubectl_aliases
    ln -sv ${DIR}/fish/theme.fish $HOME/.config/fish/theme.fish
    ln -sv ${DIR}/alacritty/alacritty.yml $HOME/.config/alacritty/alacritty.yml

    ln -sv ${DIR}/mutt/muttrc $HOME/.mutt/muttrc

    ln -sv ${DIR}/lldb/lldbinit $HOME/.lldbinit
    ln -sv ${DIR}/lldb $HOME/lldb 
}


function enable_fastkeyboard() {
    # set keyboard repeat to very fast need to relogin after running this command
    defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
    defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
}

function showhelp() {
    echo "boostrapper"
    echo
    echo "link - link all configurations to proper directory"
    echo "enable-fastkeyboard - write mac os key repeat to very low latency"
    echo "help - show this message"
}


CMD="$1"
shift

case "$CMD" in
    link) link $@;;
    enable-fastkeyboard) enable_fastkeyboard;;
    *) showhelp;;
esac


exit 0
