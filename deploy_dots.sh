#!/bin/sh

for f in gitconfig gitconfig tmux.conf profile
do
  ln -s `realpath $f` ~/.$f
done

ln -s `realpath nvim` ~/.config/nvim
