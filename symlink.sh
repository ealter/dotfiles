#!/bin/bash

#Creates a symbolic link for the vimrc in your home directory
if [ -f ~/.vimrc ]; then
  mv ~/.vimrc ~/.vimrc.backup
  echo "Making a backup of ~/.vimrc. The backup is ~/.vimrc.backup"
fi

ln -T $(dirname $0)/.vimrc ~/.vimrc
