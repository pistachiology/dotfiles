#!/bin/sh

layout=$(setxkbmap -query | grep layout | awk 'END{print $2}')
case $layout in
  th)
    setxkbmap us -variant dvp
    ;;
  us)
    setxkbmap th
    ;;
  *)
    setxkbmap us -variant dvp
    ;;
esac
# change repeat rate
xset r rate 150 50
# change caplocks to escape
setxkbmap -option caps:escape

