#!/bin/sh

for f in dots/*
do
  name=$(basename ${f})
  test -e ~/.${name} && (echo "backup ~/.${name} to ~/${name}.bak"; mv ~/.${name} ~/${name}.bak;)
  ln -s `realpath ./${f}` ~/.${name}
done

test -e ~/.config/nvim && (echo "backup ~/.config/nvim to ~/nvim.bak"; mv ~/.config/nvim ~/nvim.bak;)
mkdir -p ~/.config
ln -s `realpath nvim` ~/.config/nvim
