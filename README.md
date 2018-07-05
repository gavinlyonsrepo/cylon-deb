Overview
--------------------------------------------
* Name: cylondeb
* Title : cylon-deb , Debian based Linux distribution maintenance program.
* Description: A TUI (terminal user interface) which allows users to 
carry out  maintenance on  an Debian based linux distributions.
The program is menu-based and written in bash.
The program is a fork and highly truncated version of the 
arch-linux maintenance program *cylon*, 
which can also be found in this repo. This program provides a
Terminal based alternative to GUI software managers found in many distros.

* Author: Gavin Lyons 


Table of contents
---------------------------

  * [Overview](#overview)
  * [Table of contents](#table-of-contents)
  * [Installation](#installation)
  * [Usage](#usage)
  * [Files](#files)
  * [Output and environment variables](#output-and-environment-variables)
  * [Dependencies](#dependencies)
  * [Features](#features)
  * [Package Lists](#package-lists)
  * [See Also](#see-also)
  * [Communication](#communication)
  * [History](#history)
  * [Copyright](#copyright)


Installation
-----------------------------------------------

A Personal Package Archives (PPA) has been created on Ubuntu
package building and hosting section of launchpad site 
called cylondeb.

Package built only for on Ubuntu 18.04 LTS (Bionic Beaver) 64bit

To install this on your system run commands in terminal

```sh
sudo add-apt-repository ppa:typematrix/cylondeb
sudo apt update
sudo apt install cylondeb
```

**or** Download latest fixed release and copy files manually as per file section table.

**or** Download latest fixed release  and run the makefile as per 
terminal commands below for version 2.2 latest release at time of writing

```sh
curl -sL https://github.com/gavinlyonsrepo/cylon-deb/archive/2.2.tar.gz | tar xz
cd cylon-deb-2.2
sudo make install
```

Usage
-------------------------------------------


Run in a terminal by typing: 

cylondeb -[options]

Options list (standalone cannot be combined):

| Option          | Description     |
| --------------- | --------------- |
| -h --help | Print cylondeb information and exit |
| -s --system | Print system information and exit |
| -v --version  | Print version information and exit |
| -p --print | Print the package lists |
| -b --bleachbit  | Shortcut to opens the bleachbit select menus |

Files
-----------------------------------------

| File  | Description |
| ------ | ------ |
| /usr/bin/cylondeb | The main shell script | 
| /usr/lib/cylondeb/modules/* | Module files containing functions |
| /usr/share/doc/cylondeb/README.md | Help file |
| /usr/share/doc/copyright | copyright file |
| /usr/share/pixmaps/cylondebicon.png | program icon |
| /usr/share/applications/cylondeb.desktop | desktop entry file |

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
$HOME/Documents/cylondeb
```

Optional Dependencies
-------------------------------------
Some functions require dependencies packages to be installed.
These optional dependencies are left to user discretion.
The user can check if optional dependencies installed with cylondeb help.

| Dependencies| Usage |
| ------ | ------ |
| aptitude | High-level interface to the package manager APT |
| deborphan | Orphaned package finder |
| debsums | Verify the integrity of installed package files |
| ppa-purge | Disables a PPA and reverts to official packages |
| bleachbit | System clean and shredding |

Features
----------------------

The features are split into two main sections.

Section one deals with system maintenance. The options here are divided 
into 3 menus. Menu one deals with routine package maintenance 
upgrading, installing, searching etc. Menu two deals with more advanced 
options such as removing obsolete and orphaned packages, Exercise care
and make backups and copys of the "packagelists" before using these options. 
Menu 3 deals has some general linux maintenance options as well as a
CLI wrapper for bleachbit. BleachBit is a free and open-source disk space 
cleaner, privacy manager, and computer system optimizer.

Section 2 is the miscellaneous section it mainly contains cylon and 
system information displays. 


**1: System update section**
* Menu one options
	* Check for updates (no download), aptitude search '~U' 
	* Upgrade all, apt update && apt dist-upgrade 
	* Display remote package information, apt-cache show 
	* Install Package, apt install 
	* Delete Package, apt remove 
	* Search for packages in the database, apt search 
	* Search for already installed packages, aptitude search '~i' 
	* Display info for locally installed packages, dpkg -s 
	* List all files owned by a given package, dpkg -L  
	* Write installed package lists to files (see package list section)
	* View dpkg log file at /var/log/dpkg.log 
	* Show all or most information about a package, apt show  
	* Show the changelog of a package, apt-get changelog 
	* Verify all packages, debsums 
	* Verify dependencies of the complete system, apt-get check 
	* Add a PPA to system,  add-apt-repository ppa: 
	* Purge a PPA from system,  ppa-purge 

*Warning*

Some of these options in menu 2 remove unwanted and unneeded packages 
and configs from system as identified by utilities. What will be 
removed is presented to user first. Please take care especially with 
deborphan options numbered  5 and 6.
These have not been tested on all debian type distros.
Recommend carry these options out after 
backups and to document process.

* Menu two options
	* Clean up all local cache, apt autoclean  
	* Removes pkgs installed by other pkgs & no longer needed, apt autoremove  
	* Remove pkg's no longer included in any repos, aptitude purge '~o' 
	* Remove orphan packages with orphaner tool
	* Remove orphaned packages automatically, 
	sudo deborphan | xargs sudo apt-get -y remove --purge
	* Removing packages and configurations which are not required 
	by any other package upon your system, deborphan -n --find-config 
	| xargs apt-get -y purge
	* delete contents of CYLONDEST output folder

* Menu 3 options
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
	* delete files 
		* Shred specific files with bleachbit
		* Shred specific folders with bleachbit
	* Clean system with bleachbit (also run by -b standalone option.)
		* Preset option based on the same options as in the GUI 
		* Custom options involved for user to pick cleaners and options
			* preview
			* clean (without overwrite, BB checks the config in GUI).
			* clean + overwrite (with overwrite permanent deletion)
	* List all open files

**2: Miscellaneous section**
* Option to open xterm terminal at output folder path in new window

* Computer system information display
	* Displays detailed information on system and package setup
	* Function also run by -s standalone option.

* Cylon information: 
	* Dependencies installation check, info and display readme file to screen 
	* Function can also run by option -h 


Package Lists
--------------- 

| Index | Contents | Filename |
| -------- | -------- | ----- |
| 1 | All installed | All_PKG |
| 2 | All native, explicitly installed | Exp_PKG |
| 3 | List orphaned packages  | noinstall_PKG |
| 4 | Get a dump of the whole system information | stats_PKG |
| 5 | List packages that were recently added to one of the installation sources | Recent_add_PKG |
| 6 | List packages not required by any other package | non-Dep_PKG |
| 7 | List packages installed automatically (as dependencies) | auto_Dep_PKG |
| 8 | Prints a list of all installation source |  Info_Source_PKG|
| 9 | List of non-standard repositories in use | non_standard_PKG |
| 10 | List Installed packages by size | install_size_PKG |
| 11 | List packages by install date  | Install_date_1_PKG |
| 12 | List packages by install date less data | Install_date_2_PKG |


### Commands used by index number in table:

1. dpkg --list | grep "^i" 
2. apt-mark showmanual
3.  deborphan 
4.  apt-cache stats 
5.  aptitude search '~N' 
6.  deborphan -anp1 
7.  apt-mark showauto 
8.  apt-cache policy 
9.  cat /etc/apt/sources.list.d/*.list | grep -v "^#" 
10.  aptitude search "~i" --display-format "%p %I" --sort installsize 
11.  grep installed /var/log/dpkg.log 
12.  grep " install " /var/log/dpkg.log 


See Also
------------------
* [aptitude](https://www.debian.org/doc/manuals/aptitude/)
* [apt](https://help.ubuntu.com/lts/serverguide/apt.html)
* [dpkg](http://manpages.ubuntu.com/manpages/zesty/en/man1/dpkg.1.html)
* [deborphan](https://www.commandlinux.com/man-page/man1/deborphan.1.html)
* [debsums](http://manpages.ubuntu.com/manpages/trusty/man1/debsums.1.html)
* [ppa-purge](http://manpages.ubuntu.com/manpages/precise/en/man1/ppa-purge.1.html)
* [bleachbit](https://en.wikipedia.org/wiki/BleachBit)

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
See changelog.md in documentation section of Upstream repository
for version control history


Copyright
---------
Copyright (C) 2017 Gavin Lyons MIT Expat.

See LICENSE.md in documentation section of Upstream repository
for more details.
