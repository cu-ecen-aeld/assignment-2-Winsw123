# Simple Makefile for writer utility
# Supports cross-compilation via CROSS_COMPILE variable (e.g. CROSS_COMPILE=aarch64-none-linux-gnu-)

# default compiler and flags
CROSS_COMPILE ?=
CC := $(CROSS_COMPILE)gcc
CFLAGS ?= -Wall -Wextra -g

SRCS := writer.c
OBJS := $(SRCS:.c=.o)
TARGET := writer

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -f $(TARGET) $(OBJS)
