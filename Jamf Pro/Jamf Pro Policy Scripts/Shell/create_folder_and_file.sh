#!/bin/sh
# creates a folder & file based on the 2 first arguments provided
# Author: @iddicted


create_folder_and_file(){
    if [[ $1 == "" ]]; then
        echo "No Parameters provided. This script requires at 2 arguments. Exiting..."
        exit 1
    elif [[ $2 == "" ]]; then
        echo "Only 1 Paraemter provided. This script requires at 2 arguments. Exiting..."
        exit 2
    else
        folderName="$1"
        fileName="$2"
        echo "Thank you for providing the correct amount of arguments. proceeding"
        mkdir -p ~/Desktop/Your\ Project/$1
        touch ~/Desktop/$1/$2
    fi
}
create_file_and_folder