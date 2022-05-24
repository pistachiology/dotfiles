#!/bin/sh

DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd)"

function link() {
    ln -sv ${DIR} $HOME/.config/nixpkgs
}


function enable_fastkeyboard() {
    # set keyboard repeat to very fast need to relogin after running this command
    defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
    defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
    defaults write com.jetbrains.intellij.ce ApplePressAndHoldEnabled -bool false
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
