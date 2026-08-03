# A Makefile sample, kept idiomatic so it is worth opening in the editor.

CC      := gcc
CFLAGS  := -Wall -Wextra -O2
LDFLAGS  = -lm
PREFIX  ?= /usr/local

SOURCES := $(wildcard src/*.c)
OBJECTS := $(SOURCES:.c=.o)
TARGET  := program

.PHONY: all clean install test
.DEFAULT_GOAL := all

all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(CC) $(LDFLAGS) -o $@ $^

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

test: $(TARGET)
	@./$(TARGET) --self-test

install: $(TARGET)
	install -d $(DESTDIR)$(PREFIX)/bin
	install -m 755 $(TARGET) $(DESTDIR)$(PREFIX)/bin

clean:
	-rm -f $(OBJECTS) $(TARGET)

ifeq ($(DEBUG),1)
CFLAGS += -g -DDEBUG
else
CFLAGS += -DNDEBUG
endif

ifdef VERBOSE
MAKEFLAGS += --debug
endif

-include config.mk
