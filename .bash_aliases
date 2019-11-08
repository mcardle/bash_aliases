# PHP Composer
export PATH="~/.config/composer/vendor/bin/:$PATH"

# IF YOU HAVE ANY USERSPECIFIC THINGS YOU WANT TO ADD, JUST PUT THEM IN ~/.bash_extra 
# AND IT AUTOMATICALLY BE INCLUDED
if [ -f ~/.bash_extra ]; then
	. ~/.bash_extra
fi

# Git commands
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gb="git branch"
alias gl="git log --oneline --graph --decorate"

# PHPUnit
alias pu="vendor/phpunit/phpunit/phpunit"

# Navigation
alias c="clear"
alias ..="cd .."
alias ...="cd ../.."
alias dir_size="du -hs"
alias disk_size="df -h"

# SYSTEM SHORTCUTS
alias df="df -Tha --total"					# Human readable root usage
alias du="du -ach | sort -h" 					# Human readable disk usage
alias free="free -mt" 						# See memory usage
alias ps="ps auxf" 						# See all processes
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"		# Run "psg bash" to get the memory and cpu usage of the bash
alias mkdir="mkdir -pv"						# Create nested directories and show which ones was created
alias wget="wget -c"						# Continue if interrupted -c
alias myip="curl http://ipecho.net/plain; echo"			# My IP

# APT commands
alias apps_upgrade="sudo apt update && sudo apt upgrade && sudo apt-get autoremove"
alias os_upgrade="appUpgrade && sudo apt dist-upgrade && sudo apt-get autoremove && sudo apt install update-manager-core && sudo do-release-upgrade"

# Download
function download_images_from_url(){
	local USAGE="Usage option 1:\ndownload_images_from_url https://some-site.com\n\nUsage option 2:\ndownload_images_from_url list.txt list\n"

	if [ ! -z "$1" ] && [ "$1" == "help" ]; then
		printf "\n$USAGE\n"
		return
	fi

	if [ -z "$1" ]; then
		printf "\nNo URL specified\n\n$USAGE\n"
		return
	fi

	if [ ! -z "$2" ] && [ "$2" == "list" ]; then
		wget -i "$1" -e robots=off -m -r -np -nH -R "index.html*" --user-agent=Mozilla/5.0
	else
		wget -e robots=off -m -r -np -nH -nd -R "html,htm,php,asp,aspx,jsp,js,css,scss,sass,less,vue,template,log,env,json,xml,doc,docx,xls,xlsx,pdf,ppt" -A "jpg,png,jpeg,gif,psd,tiff,ai,pjpeg" --user-agent=Mozilla/5.0 "$1"
	fi
}

# Strip image urls from html file
function extract_imageurls_from_file(){
	if [ ! -f "$1" ]; then
		return "File does not exist"
	fi

	if [ ! -z "$2" ]; then
		cat "$1" | grep -Eoi '<a [^>]+>' | grep -Eo 'href="([^\"])+"' | sed -e 's/href="//' -e 's/"//' >> "$2"
	else
		cat "$1" | grep -Eoi '<a [^>]+>' | grep -Eo 'href="([^\"])+"' | sed -e 's/href="//' -e 's/"//'
	fi
}

# Create PDF from .jpg files in folder (requires pdftk and img2pdf)
function create_pdf(){
	ls -1 ./*.jpg | xargs -L1 -I {} img2pdf {} -o {}.pdf
	pdftk *.pdf cat output combined.pdf
}
