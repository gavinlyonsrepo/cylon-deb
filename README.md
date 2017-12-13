Overview
--------------------------------------------
* Name: cylon-deb
* Title : Debian  Linux distribution maintenance program.
* Description: A TUI (terminal user interface) which allows users to 
carry out  maintenance on  an Debian based linux distribution.
The program is menu-based and written in bash.
The program is a fork and highly truncated version of the 
arch-linux maintenance program *cylon*, 
which can also be found in this repo.
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
  * [Communication](#communication)
  * [History](#history)
  * [Copyright](#copyright)

Installation
-----------------------------------------------

A  Personal Package Archives (PPA) has been created on Ubuntu
package building and hosting section of launchpad site 
called cylondeb.

To install this on your system run commands in terminal

```sh
sudo add-apt-repository ppa:typematrix/cylondeb
sudo apt-get update
```

Usage
-------------------------------------------


Run in a terminal by typing cylon: 

Cylon.sh -[options]

Options list (standalone cannot be combined):

| Option          | Description     |
| --------------- | --------------- |
| -h --help | Print cylon information and exit |
| -s --system | Print system information and exit |
| -v --version  | Print version information and exit |


Files
-----------------------------------------

| File  | Description |
| ------ | ------ |
| /usr/bin/cylon | The main shell script | 
| /usr/share/doc/cylon/readme.md |Help file |
| /usr/share/doc/cylon/changelog.md | History file |
| /usr/share/licenses/cylon/license.md | copyright file |
| /usr/share/pixmaps/cylonicon.png | cylon icon |
| /usr/share/applications/cylon.desktop | desktop entry file |

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
These optional dependencies are left to user discretion.
The user can check if optional dependencies installed with cylon help.

| Dependencies| Usage |
| ------ | ------ |
| aptitude |  Advanced Packaging Tool (APT) system. |
| deborphan | Orphaned package finder |



Features
----------------------

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

**2: Miscellaneous section**
* Option to open xterm terminal at output folder path in new window

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
