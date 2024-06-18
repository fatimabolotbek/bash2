#!/bin/bash 

function _gitPush {
    if [ $# = 0 ]; then 
        read -p "provide path to commit: " path
        read -p "provide commit message: " message
        git add $path
        git commit -m "$message"
        git push

    elif [ $# = 1 ]; then
         git add .
         git commit -m $1
         git push
    
    elif [ $# = 2 ]; then
        git add $1
        git commit -m $2
        git push
    
    fi
}

which git 2> /dev/null && clear
if [ $? != 0 ]; then
    echo "Installing git...."
    yum install git -y 1> /dev/null
fi 

git status 2> /dev/null && clear
if [ $? = 0 ]; then
    _gitPush
else
    echo "repository not detected"
    read -p "enter repo name: " repo
    resultCount=$(find / -name $repo | wc -l)
    if [ $resultCount -gt 1 ]; then
        echo "found more then 1 repo with name: $repo:"
        for result in $(find / -name $repo 2> /dev/null); do 
            read -p "Is this your repo? -> $result <- [y/n]" x
            if [ $x != 'y' ]; then
                echo "skipping..."
            else
                cd $result
                _gitPush
                break
            fi
        done
    else
        cd $repo_path
        _gitPush
    fi
fi