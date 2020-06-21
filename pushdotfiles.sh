#!/bin/bash

#script to install dotfiles to their correct locations

#vim
echo "Moving vim dotfiles..."
cp ~/vim/.vimrc ~/.vimrc


#bash
echo "Moving bash dotfiles..."
cp ~/bash/.bashrc ~/.bashrc

#tmux
echo "Moving tmux dotfiles..."
cp ~/tmux/.tmux.conf ~/.tmux.conf
#make files update
echo "Sourcing files..."
source ~/.bashrc

 
