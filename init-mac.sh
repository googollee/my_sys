#!/bin/sh

MY_SYS=`pwd`

defaults import com.mizage.Divvy.plist ./divvy

ln -s ~/.gitconfig ${MY_SYS}/gitconfig
ln -s ~/.gitignore ${MY_SYS}/gitignore
ln -s ~/.tmux.conf ${MY_SYS}/tmux.conf
ln -s ~/.zshrc ${MY_SYS}/profile
mkdir -p ~/.config
ln -s ~/.config/nvim ${MY_SYS}/nvim
