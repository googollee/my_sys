#!/bin/sh

MY_SYS=`pwd`

defaults import com.mizage.Divvy.plist ./divvy

ln -s ${MY_SYS}/gitconfig ~/.gitconfig
ln -s ${MY_SYS}/gitignore ~/.gitignore
ln -s ${MY_SYS}/tmux.conf ~/.tmux.conf
ln -s ${MY_SYS}/profile ~/.zshrc
mkdir -p ~/.config
ln -s ${MY_SYS}/nvim ~/.config/nvim
