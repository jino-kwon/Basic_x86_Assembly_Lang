;Lab 10
;Jino Kwon
;set path="c:\Users\jino\Desktop\Masm615"
;ml /coff /c /I C:\Users\jino\Desktop\Masm615\Include lab10.asm
;link32 /LIBPATH:C:\Users\jino\Desktop\Masm615\LIB /SUBSYSTEM:console lab10.obj irvine32.lib kernel32.lib user32.lib

TITLE lab10	(lab10.asm)
INCLUDE Irvine32.inc

.data
;wv is a word
wv WORD 3
;dwv is a double word
dwv DWORD 5

.code
main PROC

;part a) eax=wv+dwv−6 (should display 2)
	movzx eax, wv ;extend wv to match the size
	add eax, dwv
	sub eax, 6
	call dumpRegs
;part b) wv=5wv+2 (should display 17, 11 in hex)
	mov eax, 0  ;clear data
	mov ax, wv
	mov bx, 5
	mul bx
	add eax, 2
	mov wv, ax
	call dumpRegs
;part c) ecx=36%dwv (should display 1 in ecx)
	mov eax, 0  ;clear data
	mov ebx, 0  ;clear data
	mov edx, 0  ;clear data

	mov eax, 36
	div dwv
	mov ecx, edx
	call dumpRegs
;part d) wv=(wv+5)/7wv (= 8/21)
;wv is now 17 or 11h (as updated in part b).
;the equation is (17+5) / 7*17.
;Quotient is 0 (in EAX) and remainder is 22 or 16h (in EDX)
	mov eax, 0  ;clear data
	mov ebx, 0  ;clear data
	mov ecx, 0  ;clear data
	mov edx, 0  ;clear data

	mov bx, wv
	add bx, 5   ;wv+5 in bx
	mov ax, 7 
	mul wv      ;7wv in ax
	xchg ax, bx ;switch ax and bx values
	div bx      ;(wv+5) / 7wv
	mov wv, ax  ;put quotient in wv
	call dumpRegs

	exit
main ENDP
END main