TARGET	:= program

CFLAGS	:=
LFLAGS	:=

OBJECTS	:= $(patsubst %.s, obj/%.o, $(wildcard *.s))

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(OBJECTS) | bin
	$(LD) -o bin/$@ $(LFLAGS) $^

obj/%.o: %.s | obj
	$(AS) --gstabs -c $< $(CFLAGS) -o $@

clean:
	@$(RM) -frv bin obj

bin obj:
	@mkdir $@

