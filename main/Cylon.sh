#!/bin/bash
#=========================HEADER======================================
#name:cylon
#Title : Debian Linux distro maintenance bash script. 
#Description: TUI providing Updates  
#in a single menu driven optional script Command line program users. 
#see readme.md(access thru cylon info page)
#Version 1.0-1 See changelog.md at repo for version control
#License: see license.md 
#Written by Gavin lyons 
#Software repo: https://github.com/gavinlyonsrepo/cylon_deb

#=======================GLOBAL VARIABLES SETUP=========================
#Syntax: Global: UPPERCASE  , local: XXXVar. local Array: XXXArr
#Environmental variables : CYLONDEST 

#colours for printf
RED=$(printf "\033[31;1m")
GREEN=$(printf "\033[32;1m")
YELLOW=$(printf "\033[33;1m")
BLUE=$(printf "\033[36;1m")
HL=$(printf "\033[42;1m")
NORMAL=$(printf "\033[0m") 

#prompt for select menus
PS3="${BLUE}By your command:${NORMAL}"

#set the path for the program output path DEST3
#if environmental variable CYLONDEST exists set it to DEST3
#and make the path for dest3
if [ -z "${CYLONDEST}" ]
then 
	#default path for program output
	DEST3="$HOME/Documents/Cylon/"
else 
	DEST3="$CYLONDEST"
fi
mkdir -p "$DEST3"

#====================FUNCTIONS==============================
#FUNCTION HEADER
# NAME : msgFunc
# DESCRIPTION :   prints to screen
#prints line, text and anykey prompts, yesno prompt
# INPUTS : $1 process name $2 text input
# PROCESS :[1]  print line [2] anykey prompt
# [3] print text "RGBY, norm yellow and highlight" [4] yn prompt, 
# OUTPUT yesno prompt return 1 or 0                       
function msgFunc
{
	case "$1" in 
	
		line) #print blue horizontal line of =
			printf '\033[36;1m%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =
			msgFunc norm
		;;
		anykey) #any key prompt, appends second text input to prompt
		    printf '%s' "${GREEN}" 
			read -n 1 -r -s -p "Press any key to continue $2"
			printf '%s\n' "${NORMAL}"
		;;
		
		#print passed text string
		green) printf '%s\n' "${GREEN}$2${NORMAL}" ;;
		red) printf '%s\n' "${RED}$2${NORMAL}" ;;
		blue) printf '%s\n' "${BLUE}$2${NORMAL}" ;;
		yellow)printf '%s\n' "${YELLOW}$2${NORMAL}" ;;
		highlight)printf '%s\n' "${HL}$2${NORMAL}" ;;
		
		norm) #print normal text colour
			if [ "$2" = "" ]
				then
				#just change colour to norm if no text sent
					printf '%s' "${NORMAL}"
				return
			fi
			printf '%s\n' "${NORMAL}$2" ;;
			
		yesno) #print yes no quit prompt
			local yesnoVar=""
			while true; do
				read -r yesnoVar
				case $yesnoVar in
					[Yy]*) return 0;;
					[Nn]*) return 1;;
					[Qq]*) exitHandlerFunc exitout;;
					*) printf '%s\n' "${YELLOW}Please answer: (y/Y for yes) OR (n/N for no) OR (q/Q to quit)!${NORMAL}";;
				esac
			done
		;;
		*) 
			printf '%s\n' "ERROR unknown input to msgFunc"
			 ;;
	esac
}


#FUNCTION HEADER
# NAME :  exitHandlerFunc 
# DESCRIPTION: error handler deal with user 
#exists and path not found errors and internet failure 
# INPUTS:  $2 text of internet site down or filename
# PROCESS : exitout DEST 1-6 netdown or file error
function exitHandlerFunc
{
	#double square brackets without use of quotes on matching pattern 
	#for glob support
	if [[ "$1" = DEST* ]]
	then
		msgFunc red "Path not found to Destination directory"
	fi
	case "$1" in
			exitout) msgFunc norm "";;
			DEST3) msgFunc norm "$DEST3" ;;
			DEST4) msgFunc red "Path not found to directory"  ;;
			netdown) msgFunc red "Internet connectivity test to $2 failed" ;;
			fileerror) msgFunc red "File error $2"  ;;
			*) msgFunc yellow "unknown input to error handler";;
	 esac
	msgFunc yellow "Goodbye $USER!"
	msgFunc anykey "and exit."
	if [ "$1" = "exitout" ]
	then
		#non-error exit
		exit 0
	fi 
	exit 1
}

#FUNCTION HEADER
# NAME : DisplayFunc
# DESCRIPTION : Function to display main menu
function DisplayFunc
{
msgFunc blue "Main Menu:"
	local choiceMainVar
	local optionsMArr=(
	"Updates" "xterm terminal" \
	  "System information" "Cylon information"  "Exit"\
	)
	select choiceMainVar in "${optionsMArr[@]}"
	do
	case "$choiceMainVar" in
			"${optionsMArr[0]}")   # update menu for deb
				debupdateFunc
			;;
			"${optionsMArr[1]}")  # open a terminal
				xterm -e "cd $DEST3  && /bin/bash"
				msgFunc anykey
			;;

			"${optionsMArr[2]}") #system info
				HelpFunc "SYS"
			;;
			"${optionsMArr[3]}")  # cylon info
				HelpFunc "HELP"
			;;
			*)#exit
				exitHandlerFunc exitout 
			;;
	esac
	break
	done

}

#FUNCTION HEADER
# NAME :            HelpFunc
# DESCRIPTION :     two sections one prints various system information the
# other cylon information and the installed readme file
# INPUTS : $1 process name either HELP or SYS    
# PROCESS :[1] HELP =cylon info [2] SYS   =system info
function HelpFunc 
{
clear
msgFunc line
if [ "$1" = "HELP" ]
	then
	msgFunc green "Cylon information and readme.md file  display." 
	msgFunc line 
	msgFunc norm "Written by G.Lyons, Reports to  <glyons66@hotmail.com>"
	msgFunc norm "Version=$(dpkg -s cylon 2> /dev/null | grep Version)"
	msgFunc norm "Cylon program location = $(which cylon)"
	msgFunc norm "Folder for Cylon output data = $DEST3"
	if [ -z "${CYLONDEST}" ]
	then 
		msgFunc norm "Environment variable CYLONDEST is not Set"
	else 
		msgFunc norm "Environment variable CYLONDEST is set to $CYLONDEST"
	fi
	msgFunc anykey "and check which dependencies are installed"
	clear
	msgFunc norm " "
	msgFunc green "Dependencies"
	# Aptitude package mangement utility
	checkPacFunc aptitude
	# deborphan utility
	checkPacFunc deborphan
	msgFunc anykey
	clear
elif [ "$1" = "SYS" ]
	then
	msgFunc green "System Information display"
	msgFunc line
	msgFunc green "Computer Information"
	msgFunc norm "Uptime = $(uptime -p)"
	msgFunc norm "Kernal = $(uname -svr)"
	msgFunc norm "Operating System = = $(uname -mo)"
	msgFunc norm "Network node name = $(uname -n)"
	msgFunc norm "User name = $USER"
	msgFunc norm "Screen Resolution = $(xrandr |grep "\*" | cut -c 1-15)"
	msgFunc norm "CPU = $(grep name /proc/cpuinfo  | tail -1)"
	mem=($(awk -F ':| kB' '/MemTotal|MemAvail/ {printf $2}' /proc/meminfo))
	memused="$((mem[0] - mem[1]))"
	memused="$((memused / 1024))"
	memtotal="$((mem[0] / 1024))"
	memory="${memused}MB / ${memtotal}MB"
	msgFunc norm "RAM used/total = ($memory)"
	msgFunc anykey
	clear
	msgFunc green "Installed Packages Information"
	msgFunc yellow "TODO  n/a 30-11-17" 
	msgFunc anykey
	clear
fi
}

#FUNCTION HEADER
# NAME :           checkinputFunc
# DESCRIPTION:CHECK INPUT OPTIONS from linux command line arguments passed to program on call
# INPUTS :  $1 user input option
#-v display version and exit
#-s display system info and exit
#-h display cylon info and exit 
function checkinputFunc
{
case "$1" in
	"");;

	-v|--version)
		msgFunc green "Version=$(dpkg -s cylon 2> /dev/null | grep Version)"
		;;
	-s|--system)
		HelpFunc SYS
		;;
	-h|--help)
		HelpFunc HELP
		;;
	*)	msgFunc red    "Invalid option!"
		msgFunc yellow "Usage: -h -s -v "
		msgFunc yellow "See readme.md for details at cylon -h "
	;;
esac

#was there a input if yes quit?
if [ -n "$1" ] 
	then
		msgFunc anykey
		exit 0 
fi
}

#FUNCTION HEADER
# NAME : makeDirFunc
# DESCRIPTION :  makes a directory with time/date stamp and enters it
#Directory used for program output and backups. 
# INPUTS : $1 text is appended to name  $2 bit flag  to change dir or not
function makeDirFunc
{
			local dirVar=""
			#makes dirs for output appends passed text to name
			#check if coming from system backup other path 1 yes 0 no.
			if [ "$2" != 1 ]
				then 
				cd "$DEST3" || exitHandlerFunc DEST3
			fi
			dirVar=$(date +%H%M-%d%b%y)"$1"
			mkdir "$dirVar"
			cd "$dirVar" || exitHandlerFunc DEST4
			msgFunc norm "Directory for output made at:-"
			pwd	 
}

#FUNCTION HEADER
# NAME : 	debupdateFunc
# DESCRIPTION : debian  manager options
# PROCESS : See options array      
#NOTE gnu-netcat is neeeded for the first option.      
function 	debupdateFunc
{
clear		
while true; do
		   #Pacman package manager options:
		   msgFunc line
		   msgFunc green "Updates" 
		   msgFunc line
		   msgFunc blue "Update  options:-"
			options=("Check for updates (no download), aptitude search '~U'" "Upgrade all, apt-get update && apt-get dist-upgrade" \
			 "Display info about a package, apt-cache show " "Install Package, apt install" \
			 "Search for packages in the database, apt search" \
			 "Delete Package, apt remove" "Search for already installed packages, aptitude search '~i'" \
			 "Display  info for locally installed packages, dpkg -s" "List all files owned by a given package, dpkg -L " \
			 "Clean up all local cache, apt-get autoclean "\
			 "Write installed package lists to files" "Remove all packages not required as dependencies), apt-get autoremove " \
			  "Return to main menu")
			select choicep in "${options[@]}"
			do
			case "$choicep" in
					"${options[0]}")
					msgFunc green "Updates ready:-.... "
						msgFunc norm   "Number of  updates ready...> $(aptitude search '~U' | wc -l)"
						aptitude search '~U' 
					;;
					"${options[1]}") #update system
						msgFunc green "Update system "
						sudo apt-get update  && sudo apt-get dist-upgrade
					;;
					"${options[2]}") # Display extensive information about a given package
						msgFunc green "Display information  for Package."
						msgFunc norm "Please enter package name"
						read -r pacString
                        apt-cache show  "$pacString"
					;;
					"${options[3]}") # Install Package
						msgFunc green "Install package."
						msgFunc norm "Please enter package name"
						read -r pacString
                        sudo apt install "$pacString"
					;;
					"${options[4]}")   #Search Repos for Package
						msgFunc green "Search for packages in the database."
						msgFunc norm "Please enter package name"
						read -r pacString
                         apt search "$pacString"
					;;
					"${options[5]}") #Delete Package
						msgFunc green "Delete Package."
						msgFunc norm "Please enter package name"
						read -r pacString
                        sudo apt-get remove "$pacString"
					;;
					"${options[6]}")   #Search for already installed packages
						msgFunc green "Search for already installed packages."
						msgFunc norm "Please enter package name"
						read -r pacString
                        aptitude search "~i(~n "$pacString"|~d "$pacString")"

					;;
					"${options[7]}") #Display extensive information about a given package(local install)
						msgFunc green "Display information  for Package."
						msgFunc norm "Please enter package name"
						read -r pacString
                        dpkg -s "$pacString"
					;;
					"${options[8]}") #List all files owned by a given package.
						msgFunc green "List all files owned by a given package."
						msgFunc norm "Please enter package name"
						read -r pacString
                         dpkg -L "$pacString"
					;;
					
					"${options[9]}")  msgFunc green  "Clean up all local cache."
					#Clean up all local caches. 
					#Autoclean removes only unneeded, obsolete information. 
					sudo  apt-get autoclean 
					;;
					"${options[10]}")msgFunc green "Writing installed package lists to files at :"
						pkglistFunc
					;;
					"${options[11]}")   #delete orphans
						msgFunc green "Delete orphans!"
						#Remove all packages not required as dependencies (orphans)
						sudo  apt-get autoremove 
					;;
				
						*)  #exit  
						msgFunc green "Done!"	
						return
						;;
			esac
			break
			done
			
msgFunc green "Done!"	
msgFunc anykey 
done
}

#FUNCTION HEADER
# NAME :  pkglistFunc
#INPUT $1 Backup if called from backup do not create directory
# DESCRIPTION :creates a copy of packages list see below.
function pkglistFunc
{
				msgFunc green "Making a copy of package lists "
				#check for input if Backup called from backup do not create dir
				if [ "$1" != "Backup" ]
				then
					makeDirFunc "-PKGINFO"
				fi
				
						#all packages 
						dpkg -l   > All_PKG.txt
						#native, explicitly installed package
						apt-mark showmanual > Exp_PKG.txt
						#foreign installed (AUR etc))
						deborphan > ForPKG.txt
}

#FUNCTION HEADER
# NAME : checkPacFunc
#DESCRIPTION : Checks if package installed 
#PROCESS: check if package(passed $1) installed if NOMES passed 
#as $2 goto menu display mode and appends passed $3
#NOMES =no message
# INPUTS : $1(package $2(NOMES flag) or (append text))
#OUTPUTS: returns 0 for installed 1 for not installed    
function checkPacFunc
{
	local pacVar=""
	pacVar=$(dpkg -l "$1" 2> /dev/null)
	if [ -n "$pacVar" ]
	then #installed
		#if text input is NOMES skip install good message
		if [ "$2" = "NOMES" ] 
		then 
			printf '%s' "$1"
		else
			printf '%s\n' "$1 is Installed $2"
		fi
		return 0
	else #not installed
		#if text input is NOMES skip install bad message
		if [ "$2" = "NOMES" ] 
		then
			printf '%s' "$1 n/a"
		else
			printf '%s\n' "${RED}$1 is Not installed${NORMAL} $2"
		fi
		return 1
	fi 
}


#==================MAIN CODE====================================
#call check for user input options
checkinputFunc "$1"
clear
#Display opening screen title 
msgFunc line                   
msgFunc highlight "Version=$(dpkg -s cylon_deb 2> /dev/null | grep Version)"
msgFunc highlight "Debian based Linux Distro Maintenance Program "
msgFunc norm "$(date +%T-%d-%a-Week%U-%b-%Y)"
msgFunc norm "Unix epoch time $(date +%s)     "
msgFunc line

#loop until user exit 
while true; do
	#reset path to $HOME
	cd ~ || exitHandlerFunc DEST4
	#call the display main menu function
	DisplayFunc
done
#====================== END ==============================
