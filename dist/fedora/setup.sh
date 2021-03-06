#!/bin/bash

echo -e "\nEntering Fedora configuration directory ...\n"

echo "=================================================================================="
echo "Setuping Vim ..."
sudo dnf install vim -y
cp -r $DIST_ROOT/vim/vim ~/.vim
cp $DIST_ROOT/vim/vimrc ~/.vimrc
echo "Vim Setup Done"
echo "=================================================================================="

echo -e "\n=================================================================================="
echo "Setuping Tmux ..."
sudo dnf install tmux -y
cp $DIST_ROOT/tmux/tmux.conf ~/.tmux.conf
cp $DIST_ROOT/tmux/tmux.conf.local ~/.tmux.conf.local
echo "Tmux Setup Done"
echo "=================================================================================="

echo -e "=================================================================================="
echo "Setuping Powerline ..."
sudo dnf install powerline powerline-fonts -y
grep -q "powerline-daemon" ~/.bashrc
[ $? -ne 0 ] && cat powerline/bashrc >> ~/.bashrc
sudo dnf install python-pip
pip install powerline-gitstatus --user
POWERLINE_LOCAL_CONFIG=~/.config/powerline/
POWERLINE_GLOBAL_CONFIG=/etc/xdg/powerline/config_files/
mkdir -p $POWERLINE_LOCAL_CONFIG
sudo cp -r $POWERLINE_GLOBAL_CONFIG/* $POWERLINE_LOCAL_CONFIG
sudo chown $USER:$USER $POWERLINE_LOCAL_CONFIG -R
cp -r $DIST_ROOT/powerline/{colorschemes,themes} $POWERLINE_LOCAL_CONFIG
powerline-daemon --replace
exec bash
echo "Powerline Setup Done"
echo "=================================================================================="
