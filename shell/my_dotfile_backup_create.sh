#!/bin/bash

# Script to backup old dotfiles and create new dotfiles directory
# https://www.placona.co.uk/1224/linux/managing-your-dotfiles-the-right-way/

echo "Make dotfiles directory in home folder and move .bashrc .vimrc .vim to ~/dotfiles"

mkdir ~/dotfiles
mv ~/.bashrc ~/dotfiles/.bashrc
mv ~/.vimrc ~/dotfiles/.vimrc
mv ~/vim ~/dotfiles/vim

########## Variables

dir=~/dotfiles

# dotfiles directory
olddir=~/dotfiles_old

# old dotfiles backup directory
files=".bashrc .vimrc .vim"

# list of files/folders to symlink in homedir
##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"

mkdir -p $olddir

echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir

echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do

echo "Moving any existing dotfiles from ~ to $olddir"

mv ~/$file ~/dotfiles_old/

echo "Creating symlink to $file in home directory."

ln -s $dir/$file ~/$file
done

source ~/.bashrc
source ~/.vimrc
