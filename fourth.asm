TITLE quiz	(fourth.asm)
INCLUDE Irvine32.inc

.data
num DWORD ?
;Declare an array called ints that contains 93 unsigned 16 bit integers.
;initialized with a random number 3
ints WORD 93 DUP(3)
;pointer to the array
;ptr DWORD ints﻿﻿

.code
main PROC
	movzx eax, ints[2 * TYPE ints]
	add eax, 9
	mov num, eax

	mov eax, num  ;12 (9+3) should be in eax now
	mov esi, 7    ;put 7 in esi
	mul esi
	mov ebx, eax  ;move the result(84) to ebx
	call dumpRegs

	movzx eax, ints[9 * TYPE ints] ;put ints[9] in eax
	mov esi, 6    ;put 6 in esi
	mul esi       ;ints[9]*6
	add eax, 3    ;add 3 to the result of ints[9]*6
	mov ebx, 4
	div ebx       ;divide by 4
	mov num, eax  ;put the quotient('5') in num variable.
	mov ecx, num
	call dumpRegs

	mov edi, OFFSET ints
	mov ecx, LENGTHOF ints
	mov eax, 3
	mov esi, 1
L1:
	mul esi
	mov [edi], eax
	mov eax, 3
	add esi, 1
	add edi, TYPE ints
	loop L1
	movzx ebx, ints[4]
	movzx edx, ints[6]
	call dumpRegs

	exit
main ENDP
END main

COMMENT !
in data segment,
you can declare a pointer like
pInts DWORDS ints
but in code, you have to specify "ints OFFSET"

Q6)
Why does this NOT make any sense? : eax = ebx*8-num
'=' sign means the latter part is calculated at a assembly time.
(1) register name can't be a symbolic constant. EAX is already a register
(2) both values at ebx or num can't be known at assembly time. You don't know what's stored in ebx or num at assembly time.
!
