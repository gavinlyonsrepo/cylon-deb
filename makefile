
PREFIX ?= /usr

all:
	@echo Run \'make install\' to install cylondeb.

install:
	@echo 'Making directories...'
	@mkdir -p $(PREFIX)/bin
	@mkdir -p $(PREFIX)/lib/cylondeb/modules
	@mkdir -p $(PREFIX)/share/doc/cylondeb
	
	@echo 'Installing script...'
	@cp -p main/cylondeb $(PREFIX)/bin
	@chmod 755 $(PREFIX)/bin/cylondeb
	
	@echo 'Installing modules...'
	@cp -p modules/* $(PREFIX)/lib/cylondeb/modules

	@echo 'Installing Readme...'
	@cp -p README.md  $(PREFIX)/share/doc/cylondeb
	
	@echo 'Installing Desktop entry...'
	@cp -p	desktop/cylondeb.desktop $(PREFIX)/share/applications
	
	@echo 'Installing Desktop icon...'
	@cp -p	desktop/cylondebicon.png $(PREFIX)/share/pixmaps

	@echo 'DONE!'


