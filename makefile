
PREFIX ?= /usr

all:
	@echo Run \'make install\' to install cylondeb.
	@echo 'or'
	@echo Run \'make uninstall\' to uninstall cylondeb.
	
install:
	@echo 'Installing cylondeb ....' 
	@echo 'Making directories...'
	@mkdir -vp $(PREFIX)/bin
	@mkdir -vp $(PREFIX)/lib/cylondeb/modules
	@mkdir -vp $(PREFIX)/share/doc/cylondeb
	
	@echo 'Installing script...'
	@cp -vp main/cylondeb $(PREFIX)/bin
	@chmod 755 $(PREFIX)/bin/cylondeb
	
	@echo 'Installing modules...'
	@cp -vp modules/* $(PREFIX)/lib/cylondeb/modules

	@echo 'Installing Readme...'
	@cp -vp README.md  $(PREFIX)/share/doc/cylondeb
	
	@echo 'Installing Desktop entry...'
	@cp -vp	desktop/cylondeb.desktop $(PREFIX)/share/applications
	
	@echo 'Installing Desktop icon...'
	@cp -vp	desktop/cylondebicon.png $(PREFIX)/share/pixmaps

	@echo 'DONE!'

uninstall:
	@echo 'Uninstalling cylondeb ...'
	
	rm -vf $(PREFIX)/bin/cylondeb
	rm -vf $(PREFIX)/lib/cylondeb/modules/*Module
	rm -vf $(PREFIX)/share/doc/cylondeb/README.md
	rm -vf $(PREFIX)/share/applications/cylondeb.desktop
	rm -vf $(PREFIX)/share/pixmaps/cylondebicon.png
	
	@echo 'DONE!'

