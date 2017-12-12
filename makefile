
PREFIX ?= /usr

all:
	@echo Run \'make install\' to install cylon.

install:
	@echo 'Making directories...'
	@mkdir -p $(PREFIX)/bin


	@echo 'Installing binaries...'
	@cp -p main/Cylon.sh $(PREFIX)/bin/cylon
	@chmod 755 $(PREFIX)/bin/cylon



uninstall:
	@echo 'Removing files...'
	@rm -rf $(DESTDIR)$(PREFIX)/bin/cylon



