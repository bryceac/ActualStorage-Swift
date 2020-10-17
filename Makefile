prefix ?= /usr/local
bindir = $(prefix)/bin
SYS := $(shell $(CC) -dumpmachine)
SWIFT_FLAGS =

ifneq (, $(findstring linux, $(SYS)))
SWIFT_FLAGS = -c release
else
SWIFT_FLAGS = -c release --disable-sandbox
endif

build:
	swift build $(SWIFT_FLAGS)
install: build
ifneq (, $(findstring darwin, $(SYS)))
	test ! -d $(bindir) && mkdir -p $(bindir)

	install ".build/release/actual" "$(bindir)/actual"
	
	test ! -d $(bindir)/actual_actual.resources && mkdir -p $(bindir)/actual_actual.resources

	rsync -zavrh --progress ".build/release/actual_actual.resources" "$(bindir)/actual_actual.resources"

	chmod -R 755 $(bindir)/actual_actual.resources
else
	install -D ".build/release/actual" "$(bindir)/actual"

	mkdir -p $(bindir)/actual_actual.resources

	rsync -zavrh --progress ".build/release/actual_actual.resources" "$(bindir)/actual_actual.resources"

	chmod -R 755 $(bindir)/actual_actual.resources
endif
uninstall:
	rm -rf "$(bindir)/actual"

	rm -rf "$(bindir)/actual_actual.resources"
clean:
	rm -rf .build
.PHONY: build install uninstall clean