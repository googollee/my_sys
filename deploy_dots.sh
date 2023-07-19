#!/bin/sh

for f in gitconfig gitconfig tmux.conf profile
do
  test -e "${HOME}/.$f" && echo "$f exists" || ln -s `realpath ./$f` "${HOME}/.$f"
done

test -e "${HOME}/.config/nvim" && echo "nvim exists" || ln -s `realpath nvim` ~/.config/nvim
