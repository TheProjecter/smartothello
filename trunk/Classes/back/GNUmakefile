.PHONY: all clean debug

ifeq ($(shell uname),Darwin)
PLATFORM:=mac
else
PLATFORM:=gnu
endif

INCPATH:=-I/usr/local/include
LIBPATH:=-L/usr/local/lib

LIBS:=-lobjc 
ifeq ($(PLATFORM),gnu)
LIBS+=-lgnustep-base
endif

ifeq ($(PLATFORM),mac)
LIBS+=-framework Foundation
endif

SRCS:= \
	SOStrategyComputer.m \
	SOBoardBasicImplementation.m \
	TestBasicBoard.m

OBJS:=$(SRCS:.m=.o)

DEPS:=$(SRCS:.m=.d)

TARGET:=TestBasicBoard

GCC:=gcc
RM:=rm -rf

OBJC:=$(GCC) $(INCPATH) 
LINK:=$(GCC) $(LIBPATH)

OBJCFLAGS+=$(CFLAGS)


all: $(TARGET)

%.d: %.m
	@$(OBJC) $(OBJCFLAGS) $^ -MM > $@

%.o: %.m
	$(OBJC) $(OBJCFLAGS) $< -c -o $@

$(TARGET): $(OBJS)
	$(LINK) $^ -o $@ $(LIBS)

clean:
	$(RM) $(OBJS) $(DEPS) $(TARGET)

debug:
	$(MAKE) all "CFLAGS=-g -O0 -DDEBUG"

-include $(DEPS)
