Overview
--------------------------------------------
* Name: cylon_deb
* Title : Debian  Linux distribution maintenance program.
* Description: A TUI (terminal user interface) which provides updates, maintenance, 
backups and system checks for an Debian based linux distribution.
This program provides numerous tools 
to Debian Linux users. The program is menu-based and written in bash.
The program is mainly text based  but also uses dialog GUI's 
at a few points mainly for directory and file selection. 
The program is a fork and highly truncated version of the 
arch-linux maintenance program *cylon*, which can also be found in this repo.
* Main Author: Gavin Lyons 


Table of contents
---------------------------

  * [Overview](#overview)
  * [Table of contents](#table-of-contents)
  * [Installation](#installation)
  * [Usage](#usage)
  * [Files and setup](#files-and-setup)
  * [Output and environment variables](#output-and-environment-variables)
  * [Dependencies](#dependencies)
  * [Features](#features)
  * [Communication](#communication)
  * [History](#history)
  * [Copyright](#copyright)

Installation
-----------------------------------------------
TO DO: Create a PPA and Deb file. Describe the installation process. 

Usage
-------------------------------------------

The program installs an icon in system application menus under system.
It can be also run in a terminal by typing cylon: 

cylon -[options]

Options list (standalone cannot be combined):

| Option          | Description     |
| --------------- | --------------- |
| -h --help | Print cylon information and exit |
| -s --system | Print system information and exit |
| -v --version  | Print version information and exit |
| -c --config   | Opens the cylon config file for editing and exit |
| -m --maint | Runs Automatic system maintenance scan This carries many of the menu functions in system maintenance menu in a single sweep, It will not change system just create report files|
| -p --print | print the package lists (REF1) |

Files and setup
-----------------------------------------

| File Path | Description |
| ------ | ------ |
| /usr/bin/cylon | The main shell script |
| /usr/lib/cylon/modules/*_module |8 library files containing functions |
| /usr/share/doc/cylon/readme.md |Help file |
| /usr/share/doc/cylon/changelog.md | History file |
| /usr/share/licenses/cylon/license.md | copyright file |
| /usr/share/pixmaps/cylonicon.png | cylon icon |
| /usr/share/applications/cylon.desktop | desktop entry file |
| $HOME/.config/cylon/cylonCfg.conf | config file, optional, user made, not installed |

README.md is displayed to screen by a menu option on cylon info page.

Config file: The user can create an optional config file, used mainly 
for custom system backup. If the user is not using the system backup option 
or ccrypt menu function. the user does not need config file.
* NAME: cylonCfg.conf 
* PATH: ``` $HOME/.config/cylon/cylonCfg.conf ```

* SETTINGS:
"DestinationX" is the path for backups.
"gdrivedestX" is remote google drive directory file ID
(see gdrive readme for setup and how to get file id numbers)
and "gdriveSourceX" is the local directory source.
"rsyncsource" and "rsyncdest" provide the source and destination paths 
for rsync option in backup menu.
"myccfile" is a setting for ccrypt utility, 
a path to a default file for ease of use.
If config file missing the System uses hard-coded dummy defaults.
The config file can be edited from a main menu option or by option -c

cylonCfg.conf file setup example:
Just copy and paste this into file and change paths for your setup.


> Destination1="/run/media/$USER/Linux_backup"
>
> Destination2="/run/media/$USER/iomega_320"
>
> gdriveSource1="$HOME/Documents"
>
> gdriveSource2="$HOME/Pictures"
>
> gdriveSource3="$HOME/Videos"
>
> gdriveSource4="$HOME/.config"
>
> gdriveDest1="foo123456789"
>
> gdriveDest2="foo125656789"
>
> gdriveDest3="foo123666689"
>
> gdriveDest4="foo123662222"
>
> rsyncsource="$HOME/"
>
> rsyncDest="/run/media/$USER/Linux_backup/foo"
>
> myccfile="$HOME/TEST/test.cpt"
>



Output and environment variables
-------------------------------------

CYLONDEST is an optional custom environmental variable
used by program. If variable CYLONDEST is not set or does not exist, 
cylon uses the default path. 
Most system output (logfiles, downloads and updates etc) 
is placed at below path, unless otherwise specified on screen.
Output folders are created with following time/date stamp syntax HHMM-DDMONYY-X 
where X is output type i.e download, update etc. The default path is:

```sh
$HOME/Documents/Cylon
```

Optional Dependencies
-------------------------------------
Some functions require dependencies packages to be installed.
The optional dependencies are left to user discretion.
Software will check for missing dependencies and report if user 
tries to use a function which requires a missing one.
Software will display installed dependencies packages on cylon info page.
also "n/a" is displayed besides uninstalled options in menus.

| Dependencies| Usage |
| ------ | ------ |
| dialog |  used to make GUIs menus (Non-optional) |
| ccrypt |  used for encrypting |
| netcat | to check for internet connection | 
| rsync | for rsync backup function |
| inxi  | CLI system information script |
| aptitude |  Advanced Packaging Tool (APT) system. |
| deborphan | Orphaned package finder |
| gdrive    | google drive client |


Features
----------------------
The program functions are divided into 5 sections:
update, maintenance, backup, security,  and miscellaneous.
The update section is the core of the program.
The maintenance section provides a variety of scans and checks.
The backup section provides a wrapper for gdrive program. as well as ability
to backup system using various tools.
The security section provides a wrapper for ccrypt and a password generator.
Other misc functions include an option to edit config file, information menus for
system and cylon. 

**1: System update section**
* Update options
	* Check for updates (no download)
	* Upgrade packages
	* Display extensive information for package in database
	* Install Package
	* Search for packages in the database
	* Remove Package
	* Search for already installed packages
	* Display extensive information for installed package 
	* List all files owned by a given package
	* Clean up the local cache.
	* Write installed package lists to files (REF1)
	* Remove all packages not required as dependencies 

	
	
**2: System maintenance section**
* System maintenance menu
	* All Failed Systemd Services and system status
	* All Failed Active Systemd Services
	* Check log Journalctl for Errors
	* Check log Journalctl for fstrim SSD trim (check for SSD in system)
	* Analyze system boot-up performance
	* Check for broken symlinks
	* Check for files not owned by any user or group
	* Diskspace usage 
	* Old configuration files scan, output to files
	* Find system inode usage
	* Find largest files
	* Print sensors information
	* Vacuum journal files
	* Delete core dumps 
	* Delete Trash 
	* Delete Download directory
	* Delete Cylon output folder $HOME/Documents/Cylon/ or $CYLONDEST
	* inxi - system information display with logging of results
	 
**3: System backup section**
* System backup
	* Optional destination path as defined in script or custom path
	* Make copy of  MBR  primary partition with dd
	* Make a copy of etc dir
	* Make a copy of home dir
	* Make tarball of all except tmp dev proc sys run
	* Make copy of package lists(REF1)
	* Rsync backup option 
	* gdrive options
		* List all syncable directories on drive
		* Sync local directory to google drive (path 1 config file)
		* Sync local directory to google drive (path 2 config file )
		* Sync local directory to google drive (path 3 config file)
		* Sync local directory to google drive (path 4 config file)
		* List content of syncable directory
		* Google drive metadata, quota usage
		* List files
		* Get file info
		
**4: System security section**
* System security men
	* ccrypt - encrypt and decrypt files:
		* config file path option for ease of use.
		* Encrypt a file 		     
		* Decrypt a file
		* Edit decrypted file
		* Change the key of encrypted file
		* View encrypted file	
	* password generator


**5: Miscellaneous section**
* Option to open xterm terminal at output folder path in new window

* Config file view/edit option.

* Computer information display
	* Displays detailed information on system and package setup
	* Function also run by -s standalone option.

* Cylon information: 
	* Dependencies installation check, info and display readme file to screen 
	* Function can also run by option -h 

REF1: package lists 


| Index | Contents | Filename | 
| -------- | -------- | ----- |
| 1 | All installed | All_PKG | 
| 2 | All native, explicitly installed | Exp_PKG.txt | 
| 3 | All foreign installed | ForPKG.txt | 


Communication
-----------
If you should find a bug or you have any other query, 
please send a report.
Pull requests, suggestions for improvements
and new features welcome.
* Contact: Upstream repo at github site below or glyons66@hotmail.com
* Upstream repository: [github](https://github.com/gavinlyonsrepo/cylon_deb)

History
------------------
* See changelog.md in documentation section for version control history

 
Copyright
---------
Copyright (C) 2017 Gavin Lyons 
This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public license published by
the Free Software Foundation, see LICENSE.md in documentation section 
for more details
