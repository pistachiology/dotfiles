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
    echo "usage "
    echo
    echo "link - link all configurations to proper directory"
    echo "enable-fastkeyboard - write mac os key repeat to very low latency"
    echo "rebuild-qweeeee - rebuild nixos qweeeee"
    echo "rebuild-qweeeee - rebuild nixos by hostname"
    echo "help - show this message"
}

CMD="$1"
shift

case "$CMD" in
    link) link $@;;
    enable-fastkeyboard) enable_fastkeyboard;;
    rebuild-qweeeee) cd ~/dotfiles && nixos-rebuild switch --upgrade --flake '.#qweeeee' --use-remote-sudo;;
    rebuild) cd ~/dotfiles && nixos-rebuild switch --upgrade --flake ".#$(hostname)" --use-remote-sudo;;
    clean-nixos)
            nix-env --delete-generations old
            nix-collect-garbage
            nix-collect-garbage -d
            nix-store --gc --print-dead
      ;;
    *) showhelp;;
esac


exit 0
