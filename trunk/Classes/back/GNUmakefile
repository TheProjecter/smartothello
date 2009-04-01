.PHONY: all clean

INCPATH:=-I/usr/local/include
LIBPATH:=-L/usr/local/lib

LIBS:=-lobjc

SRCS:=BoardBasicImplementation.m

OBJS:=$(SRCS:.m=.o)

GCC:=gcc
RM:=rm -rf

OBJC:=$(GCC) $(INCPATH) 
LINK:=$(GCC) $(LIBPATH) $(LIBS)

all: main.exe

%.o: %.m
	$(OBJC) $^ -c -o $@

main.exe: $(OBJS)
	$(LINK) $^ -o $@

clean:
	$(RM) $(OBJS)
