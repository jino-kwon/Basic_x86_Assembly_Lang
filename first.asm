;Assembling and Linking instruction
;first go to your csc215 folder using cd command
;set path="##"
;ml /coff /c /I ###\Include first.asm
;link32 /LIBPATH:###\Masm615\LIB /SUBSYSTEM:console first.obj irvine32.lib kernel32.lib user32.lib
;using Masm615 library files here.

TITLE first
INCLUDE Irvine32.inc

.data
hi BYTE '"Hello I am your skeleton!!" I said.', 0Dh,0Ah,0;
hiSiz=($-hi)  ; hi is an array we declared above. $ is a reference to the length
in1 DWORD 3   ; int in1=3;
in2 DWORD 4   ; int in2=4;
    DWORD 5
    DWORD 6,7,8
ar1 DWORD ?,10,11  ;DWORD is 4bytes so 12 in total
ar1Siz=($-ar1)     ;you will get c in hexadecimal
chrr BYTE '"a',"'a" ;here's how to create a string, "a'a

.code
main PROC    ; this is like int main(){
	a = 2*2  ; this is not generated by your program. a is just a symbolic constant here
	; ar2 = ar1+2 --> this is not going to work
	mov edx, OFFSET hi
	call writeString

	mov eax, ar1Siz
COMMENT !
The first is destination operand(eax) and the second is source operand(ar1Siz). both operands cannot be in RAM memory. the same as eax=ar1Siz in c++.
in c++, we can't assign int value to double, but you can in assembly lang as long as two variables take the same amount of space.
!
	call writeInt
	call dumpRegs
	exit   ; you always need this line. otherwise, it will crash
main ENDP   ; this is like }
END main