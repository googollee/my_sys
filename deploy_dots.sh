#!/bin/sh

for f in dots/*; do
  if [ "${f}" = "dots/mac" ]; then
     continue
  fi
  echo linking ${f}
  name=$(basename ${f})
  rm -f ~/.${name}
  ln -s `realpath ./${f}` ~/.${name}
done

echo linking nvim
mkdir -p ~/.config
rm -f ~/.config/nvim
ln -s `realpath nvim` ~/.config/nvim

# macOS
if [ `uname` = "Darwin" ]; then
  rm -f ~/.zshrc
  ln -s ~/.profile ~/.zshrc

  for f in dots/mac/*; do
    echo linking ${f}
    name=$(basename ${f})
    rm -f ~/.${name}
    ln -s `realpath ./${f}` ~/.${name}
  done
fi
