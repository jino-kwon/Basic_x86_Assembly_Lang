;Assembling and Linking instruction
;first go to your csc215 folder using cd command
;set path="c:###"
;ml /coff /c /I C:\###\Include second.asm
;link32 /LIBPATH:C:\### /SUBSYSTEM:console second.obj irvine32.lib kernel32.lib user32.lib
TITLE second		(second.asm)
INCLUDE Irvine32.inc

.data
hi BYTE '"Hello I am your skeleton!!" I said.', 0Dh,0Ah,0;
hiSiz=($-hi)  ; hi is an array we declared above. $ is a reference to the length 

in1 DWORD 3    ; int in1=3;
in2 DWORD 4
in3 BYTE 5
in4 SBYTE -6
    DWORD 6,7,8,5,89,534 ; 6 0 0 0
ar1 DWORD ?,10,11  ;DWORD is 4bytes so 12 in total
ar1Siz=($-ar1)     ;you will get c in hexadecimal
chrr BYTE '"a',"'a"
int5 WORD 5,9,3,7   ;each WORD is 2 bytes like 05 00 09 00 03 00 07 00 (every group is a byte)

.code
main PROC    ;this is like int main(){
	;ar2 = ar1+2.. this is not going to work
	mov edx, OFFSET hi
	call writeString

	;moving signed numbers when sizes don't match
	movsx eax, in4 
        call writeInt
	call dumpRegs

	;Operators
	mov eax, TYPE ar1
	mov esi, OFFSET ar1
	mov ebx, SIZEOF ar1
	mov ecx, LENGTHOF ar1 
	call dumpRegs

	mov eax, 0
	mov ax, int5+3*2 ;add and multiply would be computed at assembly time
;through built-in calculator and we do 3 times 2 because each takes 2 bytes
	mov al, BYTE PTR int5-2
	call writeInt
	call dumpRegs

	mov hi+5, '!'
	mov edx, OFFSET hi
	call writeString

;;Arithmetic
	mov eax, 6
	mov ebx, 1
	;neg al can lower byte of eax register
	mov eax, -255
	;add eax, ebx; eax=eax+ebx
	sub al, 7
	;add al, 5
	call dumpRegs
;multification
	mov ax, 10
	mov bx, 60000
	mul bx
	call dumpRegs
;division
	mov eax, 10 ;will overwrite on eax
	mov ebx, 6
	div bl
	call dumpRegs ;it shows in EAX, 0401 remainder 4 and quotient 1

	;example question in1= (5+8)/3
	mov eax,0
	mov ebx,0
	mov edx,0
	;5+8
	mov eax, 5
	add eax, 8
	;/3
	mov ebx, 3
	div ebx    ;edx:eax / ebx = eax
	mov in1, eax
	
	call dumpRegs
	exit   ; you always need this line. otherwise, it will crash
main ENDP   ; this is like }
END main