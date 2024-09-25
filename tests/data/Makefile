ASMS = $(wildcard *.s)
BINS = $(ASMS:.s=)

.PHONY: all clean
all: $(BINS)

# Need to link because GNU AS generates relocations for the call insns.
# OTOH clang is generates a .o w/o relocations for call insns, might consider
# using it in the future.
%: %.s
	$(CC) -ffreestanding -nostdlib -o $@ $@.s

clean:
	rm -f $(BINS)
