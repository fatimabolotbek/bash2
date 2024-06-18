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

if [ $# -lt 2 ]; then
	echo "2 arguments required [file] - [commit message]"
	exit 1
fi

## check for git ##
git -v > /dev/null || sudo dnf install git -y  > /dev/null

if [ -d ".git" ]; then

	cat ~/.ssh/known_hosts | grep "github" > /dev/null
	if [ $? = 0 ]; then

		if [ -f /root/.gitconfig ]; then
			_gitPush
		else
			_gitConfig
			## commit & push
			_gitPush
		fi

	else
		echo "SSH connectivy not found"
		exit 1
	fi

else
	read -p "Enter repo path: " repo
	cd $repo 
        cat ~/.ssh/known_hosts | grep "github" > /dev/null

        if [ $? = 0 ]; then

                if [ -e "/root/.gitconfig" ]; then
			echo "Test"
			_gitPush
                else
			_gitConfig
                        ## commit & push
			_gitPush
                fi

        else
                echo "SSH connectivy not found"
                exit 1
        fi
fi