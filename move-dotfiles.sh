#!/bin/bash

#script to install dotfiles to their correct locations

#vim
echo "Moving vim dotfiles..."
cp vim/.vimrc ~/.vimrc


#bash
#TODO: need to setup other bash conf files
echo "Moving bash dotfiles..."
cp bash/.bashrc ~/.bashrc
 
