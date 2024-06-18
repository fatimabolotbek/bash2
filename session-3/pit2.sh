#!/bin/bash

path="$1"
message="$2"

function _gitPush {
        git add $path
        git commit -m "$message"
        git push
}

function _gitConfig {
        read -p "Enter your github username: " git_username
        read -p "Enter your github email: " git_email
        git config --global user.name $git_username
        git config --global user.email $git_email
}

## user must provide 2 arugments
if [ $# -lt 2 ]; then
        echo "2 arguments required [file] - [commit message]"
        exit
fi

## check for git ##
git -v > /dev/null || sudo dnf install git -y  > /dev/null

## ensure we are in a repository
if [ ! -d ".git" ]; then
	read -p "Enter repo path: " repo
        cd $repo
fi

## check for ssh connectivity
cat ~/.ssh/known_hosts | grep "github" > /dev/null
if [ $? != 0 ]; then
	echo "SSH connectivy not found"
        exit
fi

## ensure git is configured
if [ ! -e "/root/.gitconfig" ]; then
	_gitConfig
fi


_gitPush