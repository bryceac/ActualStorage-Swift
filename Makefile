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

	for file in .build/releases/actual_actual.resources/*;do \
		install -m 755 $(file) $(bindir)/actual_actual.resources/ ; \
	done
else
	install -D ".build/release/actual" "$(bindir)/rext"

	mkdir -p $(bindir)/actual_actual.resources

	for file in .build/releases/actual_actual.resources/*;do \
		install -m 755 $(file) $(bindir)/actual_actual.resources/ ; \
	done
endif
uninstall:
	rm -rf "$(bindir)/actual"
clean:
	rm -rf .build
.PHONY: build install uninstall clean