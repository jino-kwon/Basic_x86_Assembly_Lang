TITLE data03
INCLUDE Irvine32.inc

.data
hi BYTE '"Hello I am your data lecture!!" I said.', 0Dh,0Ah,0
hiSiz=($-hi)

in1 DWORD 3    ; int in1=3;
in2 DWORD 4
in3 BYTE 5
in4 SBYTE -6
    DWORD 6,7,8,5,89,534 ; 6 0 0 0 
ar1 DWORD ?,10,11
ar1Siz=($-ar1)/4
chrr BYTE '"a',"a'"
int5 WORD 5,9,3,7 ; 05 00 09 00 03 00 07 00 (Every group is a byte)
pInt5     DWORD 0
.code
main PROC
	
	;mnem opd1, opd2, opd3 
	mov edx, OFFSET hi
	call writeString

	;moving signed numbers when sizes don't match.
	movsx eax,  in4
        call writeInt
	call dumpRegs

	;Operators
	mov eax, TYPE ar1
	mov esi, OFFSET ar1; 
	mov ebx, SIZEOF ar1
	mov ecx, LENGTHOF ar1 
	call dumpRegs

	;int arr[4]={10,11,12,13};
	;int i=arr[3];
	mov eax, 0
	;mov ax,int5+4*2
	mov al, BYTE PTR int5-2
	call writeInt
	call dumpRegs

	mov hi+5,'!'

	mov edx, OFFSET hi
	call writeString

;; Arithmetic

	mov eax, 6
	mov ebx, 1
	;neg al
	mov al,-255
	;add eax, ebx; eax=eax+ebx
	sub al, 7
	;add al, 5
	call dumpRegs	

	mov ax, 10
	mov bx, 60000
	mul bx
	call dumpRegs

	mov eax, 10
        mov ebx, 6
        div bl
	call dumpRegs

	
	;in1=(5+8)/3
	mov eax,0
	mov ebx,0
	mov edx,0
	;5+8
	mov eax, 5
	add eax, 8
	;/3
	mov ebx,3
	div ebx   ;edx:eax / ebx = eax
	mov in1, eax
	call dumpRegs
	;
	;

	; Offsets and pointers
	mov eax,0
	;int *esi=&int5;
	; esi++ vs *(esi)++
	;cout<<*esi;
	mov esi, OFFSET int5
	mov ax, [esi]
	call dumpRegs
        
	add esi, TYPE int5 ; next element
	mov ax,[esi]
	call dumpRegs

	mov pInt5, OFFSET Int5
	;mov ax, pInt5 ; offset? not good!!
	mov esi, pInt5
	mov ax, [esi]
	call dumpRegs

 	; Indexed operands
	mov esi, 4 
	mov ax, Int5[2*TYPE Int5]	

	call dumpRegs
;How to create a loop
	mov eax, L1; Showing the code location.
	call dumpRegs

	mov ecx,2 ;ecx works like a counter in a loop
L1:	
	mov eax, ecx
	call writeInt
	loop L1  ;decrements ecx if ecx=/=0 , jump to the label/

	exit
main ENDP
END main
