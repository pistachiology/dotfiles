#!/bin/sh

layout=$(setxkbmap -query | grep layout | awk 'END{print $2}')
case $layout in
  th)
    setxkbmap us
    ;;
  us)
    # dvorak programmer 40 percent
    setxkbmap th -variant mnc
    ;;
  *)
    setxkbmap us
    ;;
esac
# change repeat rate
xset r rate 150 50
# change caplocks to escape
setxkbmap -option caps:escape

