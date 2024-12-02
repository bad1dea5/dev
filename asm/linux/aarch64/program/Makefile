TARGET	:= program

CC		:=
DEBUG	:=

CFLAGS	:=
LFLAGS	:=

ifdef CC
AS		:= /usr/aarch64-linux-gnu/bin/as
LD		:= /usr/aarch64-linux-gnu/bin/ld
else
AS		:= as
LD		:= ld
endif

OBJECTS	:= $(patsubst %.s, obj/%.o, $(wildcard *.s))

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(OBJECTS) | bin
ifdef DEBUG
	$(LD) -o bin/$@ $(LFLAGS) $^
else
	$(LD) -s -o bin/$@ $(LFLAGS) $^
endif

obj/%.o: %.s | obj
	$(AS) -c $< $(CFLAGS) -o $@

bin obj:
	@mkdir $@

clean:
	@$(RM) -frv bin obj
