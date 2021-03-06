#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


FILE=~/.config/to
# If the file exists, read from the file    
if [ -f $FILE ]; then
    version=$(jq -r '.version' ~/.config/to)
else # If the file does not exist, set the default target to python and copy the basic config file to the target location.
    version=python
    cp $DIR/basic_config_file $FILE
fi


case "$version" in
    rust)
        TO="$DIR/rust/target/release/to"
        ;;
    lua)
        TO="$DIR/lua/main.lua"
        ;;
    python)
        TO="$DIR/python/main.py"
        ;;
    haskell)
        TO="$DIR/haskell/.stack-work/install/x86_64-linux/lts-8.0/8.0.2/bin/haskell-exe"
        ;;
    *)
        echo "to: Error! Unknown target language "$version" specified in ~/.config/to"
		echo "to: Change version in ~/.config/to to either rust, lua, python or haskell"
        #exit 1
        ;;
esac

function _to_go {

	case "$1" in
		"--add" | "-a")
			$TO add $2
			;;
		"--dirs" | "-d" | "--list" | "-l")
			$TO dirs
			;;
		"--remove" | "-r")
			$TO remove $2
			;;
        "--version" | "-v")
            $TO version
            ;;
		"--change-version" | "-c")
			echo "Warning: Not all versions have all the options implemented and additional packages might be required"
			$TO change $2 #Change the setting
			exec $DIR/source.sh #Rerun this file (executable permission needed)
			;;
		"--help" | "-h")
			echo "Usage: to [OPTION] [DIR]
    Searches the subdirectories of directories set in the settings for DIR.
    If it is found, it changes the current directory to DIR.  The default DIR
    is the value of the	HOME shell variable.

  Options:
    -a, --add                  add DIR to the settings
    -d, --dirs                 lists all directories in the settings
    -l, --list                 same as -d
    -r, --remove               remove DIR from the settings if it was in there
    -v, --version              list which version is currently being used
    -c, --change-version       changes the version being used to the value given
                               possible values: python, rust, lua or haskell
    -h, --help                 show this help text
			"
			;;
        "")
            cd
            ;;
		*)
			cd "$($TO go $1)"
	esac
}
alias to="_to_go"

function _to_list {
	local cur
	local res

	COMPREPLY=()

	cur=${COMP_WORDS[COMP_CWORD]}
	res=$( $TO list $cur )
	if [ -n "$res" ]; then
		    mapfile -t COMPREPLY < <($TO list $cur)
	fi
	compopt -o nospace
	return 0
}
complete -F _to_list to -o nospace
