
.segment "CODE"

Start:
loop:		inc $d020
				jmp loop
