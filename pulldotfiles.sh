#!/bin/bash

#script to get dotfiles currently used and move to this repo

#vim
echo "Retrieving vim dotfiles..."
cp ~/.vimrc ~/dotfiles/vim/.vimrc 


#bash
echo "Retrieving bash dotfiles..."
cp ~/.bashrc ~/dotfiles/bash/.bashrc 

#tmux
echo "Retrieving tmux dotfiles..."
cp ~/.tmux.conf ~/dotfiles/tmux/.tmux.conf 
 
