
BUILDDIR := build
SRCDIR := src

CC := cc65 --standard c99
AS := ca65
CL := cl65 --standard c99
C1541 := c1541
VICE := x64
PETCAT := petcat

CC65_ROOT := $(shell nix-store -r $$(which $(CL)) 2>/dev/null)

PROGS := $(BUILDDIR)/cprog.prg $(BUILDDIR)/asmprog.prg $(BUILDDIR)/basic/basicprog.prg $(BUILDDIR)/basic/maze.prg

.PHONY: all progs disks run clean

all: disks
	echo $(CC65_ROOT)

clean:
	rm -rf build

run: disks
	$(VICE) -8 $(BUILDDIR)/disk.d64 -9 myprogs.d64 -device9 1 -drive9type 3

$(BUILDDIR)/cprog.prg: $(BUILDDIR)/cprog.c.o
	@mkdir -p $(BUILDDIR)
	$(CL) --mapfile $(BUILDDIR)/cprog.map -t c64 -o $@ $<

$(BUILDDIR)/asmprog.prg: $(BUILDDIR)/asmprog.s.o
	@mkdir -p $(BUILDDIR)
	$(CL) --mapfile $(BUILDDIR)/asmprog.map -u __EXEHDR__ -t c64 -C c64-asm.cfg -o $@ $<

progs: $(BUILDDIR)/cprog.prg $(BUILDDIR)/asmprog.prg $(BUILDDIR)/basic/basicprog.prg

$(BUILDDIR)/disk.d64: Makefile $(PROGS)
	@mkdir -p $(BUILDDIR)
	@$(C1541) -format "disk,id" d64 $@
	@for f in $(PROGS); do \
		$(C1541) -attach $@ -write $$f $$(basename $$f .prg); \
	done

myprogs.d64:
	$(C1541) -format "myprogs,id" d64 $@

disks: $(BUILDDIR)/disk.d64 myprogs.d64

$(BUILDDIR)/%.c.o: $(SRCDIR)/c/%.c
	@mkdir -p $(BUILDDIR)
	$(CL) -c -o $@ $<

$(BUILDDIR)/%.s.o: $(SRCDIR)/asm/%.s
	@mkdir -p $(BUILDDIR)
	$(CL) -c -o $@ $<

$(BUILDDIR)/basic/%.prg: $(SRCDIR)/basic/%.bas
	@mkdir -p $(BUILDDIR)/basic
	$(PETCAT) -w2 -o $@ $<
