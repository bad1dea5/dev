#

TARGET	:= program

CFLAGS	:=
LFLAGS	:= -I/lib64/ld-linux-x86-64.so.2 -lc

SOURCES	:= $(shell find src -name '*.s')
OBJECTS	:= $(patsubst src/%.s, obj/%.o, $(SOURCES))

DEBUG	:=

#
#	Linker
#
.DELETE_ON_ERROR:
bin/$(TARGET): $(OBJECTS) | bin
	@printf "\033[33m= Linker =\033[0m\n"
ifdef DEBUG
	ld -o $@ $(LFLAGS) $^
else
	ld -s -o $@ $(LFLAGS) $^
endif
	@printf "\n"

#
#	Compiler
#
obj/%.o: src/%.s
	@mkdir -p $(dir $@)
	as -c $< $(CFLAGS) -o $@

#
#
#
bin:
	@mkdir $@

clean:
	-@$(RM) -frv bin obj

read: bin/$(TARGET)
	@readelf -a bin/$(TARGET)
