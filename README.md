# Commodore 64 Dev Environment

This Repl provides a starting point from which you can develop programs
for a Commodore 64. You can test using the [VICE emulator](https://vice-emu.sourceforge.io/).

## Makefile

A `Makefile` is provided. Clicking "Run" will run `make run`, which will
compile your code, create C64 disk images, and run the VICE emulator.

You can also type `make run` in the shell to do the same thing.

`make progs` will compile the programs. `make disks` will create the disk
images.

### Adding New Programs

If you want to add more programs beyond those in the template, the `PROGS`
variable in the Makefile needs to be edited. For C and ASM programs, you
will also need to add a rule to build the program from the source file(s).

### BASIC

Each individual file in `src/basic` will be turned into a distinct program.

For example, `src/basic/basicprog.bas` will become `BASICPROG`, and
`src/basic/maze.bas` will become `MAZE`.

### Assembly

These are 6502 microprocessor assembly files.

`src/asm/asmprog.s` is provided as an example.

### C

The demonstration C program writes some text to the screen.

It can be found at `src/c/cprog.c`.

`ccls` is used to provide code intelligence for C programs using the CC65
libraries and headers.

## Running

`make run` will run VICE with the built disk image attached as device 8.

The `myprogs.d64` file is created if it does not exist yet. This is attached
to VICE as device 9, and is provided so you can edit code within VICE, save,
and load across repl restarts.

### How to Run Programs

Once VICE loads, at the BASIC prompt:
```
LOAD "ASMPROG",8
```

Once the program loads, you can type:
```
RUN
```
to run the program.

To load the C program, replace the first `LOAD` with this:
```
LOAD "CPROG",8
```

## Writing BASIC

You can also type your BASIC programs directly into the emulator, for example:
```
10 PRINT "HELLO WORLD"
20 GOTO 10
RUN
```

Hit the Escape key to stop the program running.

Once you have written a BASIC program in the emulator, you may want
to save it.

The `myprogs.d64` disk is loaded as drive 9 in the emulator for this purpose.

Let's take this BASIC program:
```
10 PRINT "HELLO WORLD"
RUN
```

It'll print `HELLO WORLD` to the screen.

To save,
```
SAVE "HELLO",9
```

Once saved, you can load the program again after a restart:
```
LOAD "HELLO",9
LIST
RUN
```
