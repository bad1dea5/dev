#

TARGET	:= program

CFLAGS	:= -Iinclude
LFLAGS	:=

SOURCES	:= $(shell find src -name '*.cpp')
OBJECTS	:= $(patsubst src/%.cpp, obj/%.o, $(SOURCES))

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
obj/%.o: src/%.cpp
	@mkdir -p $(dir $@)
ifdef DEBUG
	g++ -g -c $< $(CFLAGS) -o $@
else
	g++ -c $< $(CFLAGS) -o $@
endif

#
#
#
bin:
	@mkdir $@

clean:
	-@$(RM) -frv bin obj

readelf: bin/$(TARGET)
	@readelf -a bin/$(TARGET)
