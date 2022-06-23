VERCMD  ?= git describe --tags 2> /dev/null
VERSION := $(shell $(VERCMD) || cat VERSION)

CPPFLAGS += -D_POSIX_C_SOURCE=200809L -DVERSION=\"$(VERSION)\"
CFLAGS   += -std=c99 -pedantic -Wall -Wextra -DJSMN_STRICT
LDFLAGS  ?=
LDLIBS    = $(LDFLAGS) -lm -lxcb -lxcb-util -lxcb-keysyms -lxcb-icccm -lxcb-ewmh -lxcb-randr -lxcb-xinerama -lxcb-shape

PREFIX    ?= /usr/local
BINPREFIX ?= $(PREFIX)/bin
MANPREFIX ?= $(PREFIX)/share/man
DOCPREFIX ?= $(PREFIX)/share/doc/archmage
BASHCPL   ?= $(PREFIX)/share/bash-completion/completions
XSESSIONS ?= $(PREFIX)/share/xsessions

WM_SRC   = archmage.c helpers.c geometry.c jsmn.c settings.c monitor.c desktop.c tree.c stack.c history.c \
	 events.c pointer.c window.c messages.c parse.c query.c restore.c rule.c ewmh.c subscribe.c
WM_OBJ  := $(WM_SRC:.c=.o)
CLI_SRC  = archmagec.c helpers.c
CLI_OBJ := $(CLI_SRC:.c=.o)

all: archmage archmagec

debug: CFLAGS += -O0 -g
debug: archmage archmagec

VPATH=src

include Sourcedeps

$(WM_OBJ) $(CLI_OBJ): Makefile

archmage: $(WM_OBJ)

archmagec: $(CLI_OBJ)

install:
	mkdir -p "$(DESTDIR)$(BINPREFIX)"
	cp -pf archmage "$(DESTDIR)$(BINPREFIX)"
	cp -pf archmagec "$(DESTDIR)$(BINPREFIX)"
	mkdir -p "$(DESTDIR)$(MANPREFIX)"/man1
	cp -p doc/archmage.1 "$(DESTDIR)$(MANPREFIX)"/man1
	cp -Pp doc/archmagec.1 "$(DESTDIR)$(MANPREFIX)"/man1
	mkdir -p "$(DESTDIR)$(BASHCPL)"
	cp -p examples/bash_completion "$(DESTDIR)$(BASHCPL)"/archmagec
	mkdir -p "$(DESTDIR)$(DOCPREFIX)"/examples
	cp -pr examples/* "$(DESTDIR)$(DOCPREFIX)"/examples
	mkdir -p "$(DESTDIR)$(XSESSIONS)"
	cp -p examples/archmage.desktop "$(DESTDIR)$(XSESSIONS)"

uninstall:
	rm -f "$(DESTDIR)$(BINPREFIX)"/archmage
	rm -f "$(DESTDIR)$(BINPREFIX)"/archmagec
	rm -f "$(DESTDIR)$(MANPREFIX)"/man1/archmage.1
	rm -f "$(DESTDIR)$(MANPREFIX)"/man1/archmagec.1
	rm -f "$(DESTDIR)$(BASHCPL)"/archmagec
	rm -rf "$(DESTDIR)$(DOCPREFIX)"
	rm -f "$(DESTDIR)$(XSESSIONS)"/archmage.desktop

doc:
	a2x -v -d manpage -f manpage -a revnumber=$(VERSION) doc/archmage.1.asciidoc

clean:
	rm -f $(WM_OBJ) $(CLI_OBJ) archmage archmagec

.PHONY: all debug install uninstall doc clean
