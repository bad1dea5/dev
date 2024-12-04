TARGET	:= program

DEBUG	:=

CFLAGS	:=
LFLAGS	:=

OBJECTS	:= $(patsubst %.s, obj/%.o, $(wildcard *.s))

.PHONY: all clean

all: $(TARGET)

#
#	Linker
#
$(TARGET): $(OBJECTS) | bin
ifdef DEBUG
	ld -o bin/$@ $(LFLAGS) $^
else
	ld -s -o bin/$@ $(LFLAGS) $^
endif

#
#	Assembler
#
obj/%.o: %.s | obj
ifdef DEBUG
	as --gstabs -c $< $(CFLAGS) -o $@
else
	as -c $< $(CFLAGS) -o $@
endif

bin obj:
	@mkdir $@

clean:
	@$(RM) -frv bin obj
