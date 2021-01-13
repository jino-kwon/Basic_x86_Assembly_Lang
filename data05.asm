TITLE data05.asm
INCLUDE Irvine32.inc

.data
;part a) 16 bit long integer
in1 WORD 8
;part b) 7 32 bit long signed integers. I chose arbitrary numbers.
ar1 SDWORD +1,-2,+3,-4,+5,-6,+7
ar1Siz = ($-ar1)/4
;part c) a null terminated string containing: Hel'l'o" Assembly.
hi BYTE "Hel'l'o",'" Assembly',0
;part d) array of 37465 8 bit long integers, all storing 215.
ar2 BYTE 37465 DUP(215)

.code
main PROC
;check the string (hi) prints correctly.
	mov edx, OFFSET hi
	call writeString
;part e) the symbolic constants to represent the sizes of your arrays
;I declared 'ar1Siz' right below 'ar1'
	mov eax, ar1Siz ;should print 7 in EAX
	call dumpRegs

;part f) Display types, offsets, num of elements, etc.
	mov eax, TYPE in1    ; display 2 (bytes) in eax
	mov esi, OFFSET ar1
	mov ebx, SIZEOF ar1  ; display 1c (4*7=28) (bytes) in ebx
	mov ecx, LENGTHOF ar2  ; display 9259 (37465) (=elements) in ecx
	call dumpRegs

COMMENT !
part g) number=4/3+anotherNumber. What are anotherNumber and number?
Answer) number is called a symbolic constant, and the ride-side is called expression. anotherNumber would be part of the expression that can be a symbolic constant itself. The symbolic constant can be used in place of a value later in the program. these symbols do not reserve storage (unlike a variable). They are only used by the assembler and can't change at runtime (again, unlike a variable).
part h)In a comment, write the way part b is stored in memory.
Answer) Taking the numbers I chose arbitrarily above, 
+1                       -2                     +3                  
[0001][0000][0000][0000][FFFE][FFFF][FFFF][FFFF][0003][0000][0000][0000]
-4                       +5                      -6              
[FFFC][FFFF][FFFF][FFFF][0005][0000][0000][0000][FFFA][FFFF][FFFF][FFFF]
+7
[0007][0000][0000][0000]
!
;part i) print the elements with index 2 and 5 in your array from part b.
; each SDWORD takes up 4 BYTES
	mov eax, 0  ;clear data
	mov ebx, 0  ;clear data

	mov eax, ar1+ 2*4  ;should print +3 in EAX
	mov ebx, ar1+ 5*4  ;should print FFFA (-6) in EBX
	
	call dumpRegs

	exit
main ENDP
END main
