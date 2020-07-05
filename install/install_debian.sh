#!/bin/bash

function dlgYN() {
    tput sc
    tput setaf 4
    printf "$1 (y/n)? "
    while :
    do
        read -n 1 -p "" YNQuestionAnswer
        if [[ $YNQuestionAnswer == "y" ]]; then
            tput rc; tput el
            printf "$1?: \e[0;32mYes\e[0m\n"
            tput sc
            eval $2=1 # Set parameter 2 of input to the return value
            break
        elif [[ $YNQuestionAnswer == "n" ]]; then
            tput rc; tput el
            printf "$1?: \e[0;31mNo\e[0m\n"
            eval $2=0 # Set parameter 2 of input to the return value
            break
        fi
    done
}

dlgYN "> Install \"Highlight, atool, w3m, mediainfo\"" res
if [ $res -eq 1 ]; then
    tput sc
    sudo apt -y install highlight atool w3m mediainfo curl zsh
    tput rc; tput ed
fi

dlgYN "> Install Oh-My-Zsh" res
if [ $res -eq 1 ]; then
    tput sc
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    tput rc; tput ed
fi

dlgYN "> Install zsh-autosuggestions" res
if [ $res -eq 1 ]; then
    tput sc
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    tput rc; tput ed
fi

dlgYN "> Install Powerline" res
if [ $res -eq 1 ]; then
    tput sc
	  pip3 install pygments
    pip3 install powerline-status
    tput rc; tput ed
fi

dlgYN "> Install powerlevel9k" res
if [ $res -eq 1 ]; then
    tput sc
	  git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
    tput rc; tput ed
fi

dlgYN "> Create symlinks" res
if [ $res -eq 1 ]; then
	CWD=$(pwd)
    tput sc
    ln -isf "$CWD/bin" ~/bin
    ln -isf "$CWD/linux/zshrc" ~/.zshrc
    ln -isf "$CWD/linux/tmux.conf" ~/.tmux.conf
  	ln -isf "$CWD/Common/vimrc" ~/.vimrc
	  ln -isf "$CWD/Common/vim" ~/.vim
    tput rc; tput ed
fi

tput setaf 3
echo "\nPlease install the font Roboto mono nerd, and enable it in your terminal."
echo "\nPlease run ':PlugInstall' in vim"
tput sgr0