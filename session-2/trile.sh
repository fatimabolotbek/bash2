#!/bin/bash
echo "Starting programing at $(date)"   # it is give as day informatin
echo "Raning program $0 with $# with pid: $$"          #$$ is prosses id 
if [ $# -le 1 ]; then  # $# is the namber is the argument 
        echo "you most provide more than 1 argument"
        exit
fi


for arg in $@; do      #$@ is give the list the arg
       useradd $arg
       if [ $? -ne 0 ]; then 
                echo "adding user $arg filed" 
        else 
                echo "welcome to Linux $arg"
        fi        
done       


