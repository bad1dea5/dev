TARGET	:= program

DEBUG	:=
CFLAGS	:=
LFLAGS	:= -I/lib64/ld-linux-x86-64.so.2

OBJECTS	:= $(patsubst %.s, obj/%.o, $(wildcard *.s))

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(OBJECTS) | bin
ifdef DEBUG
	ld -o bin/$@ $(LFLAGS) $^
else
	ld -s -o bin/$@ $(LFLAGS) $^
endif

obj/%.o: %.s | obj
	as -c $< $(CFLAGS) -o $@

bin obj:
	@mkdir $@

clean:
	@$(RM) -frv bin obj
