ASSEMBLER6502		= acme
AS_FLAGS			= -f cbm -DMACHINE_C64=0 --cpu w65c02

PROGS				= kob.prg

kob.prg:
	$(ASSEMBLER6502) $(AS_FLAGS) --outfile kob.prg main.asm

all: $(PROGS)

clean:
	rm -f $(PROGS)

run: clean kob.prg
	./x16emu -prg kob.prg -run -scale 2
