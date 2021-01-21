TITLE data07
INCLUDE Irvine32.inc

.data
;an array aw1 of words containing 99 elements. initialized with 12.
aw1 WORD 99 DUP(12)
;an array aw2 of words containing 88 elements.
aw2 WORD 88 DUP(?)
;create a pointer to aw2 called pAw2.
pAw2 DWORD aw2

.code
main PROC
;part a) Translate from Pesudomathojava : pAw2[lastElement]=aw1[1]/6
	mov ecx, 0 ;clear ecx.
	mov edx, 0 ;clear edx. make room for remainder (for a later part)

	movzx eax, aw1[1 * TYPE aw1] ;eax = aw1[1] which is 12
	mov ebx, 6
	div ebx                      ;aw1[1]/6 = 2 (in EAX)

	mov esi, pAw2
	add esi, (LENGTHOF aw2-1) * TYPE aw2
	mov [esi], eax
	movzx ecx, aw2[87*2]  ;let's check 2 is in ecx. 87 is the last element.
	call dumpRegs

;part b)Fill the aw1 with the number 21. Use a loop.
	mov edi, OFFSET aw1
	mov ecx, LENGTHOF aw1
	mov eax, 21           ;should display 15 in EAX
L1:
	mov [edi], eax
	add edi, TYPE aw1
	loop L1
	movzx ebx, aw1[98*2] ;to check the last element: 21 (15h) in EBX.
	call dumpRegs
;part c)a loop that prints all the integers from 5 to 18 in ascending order.
	mov eax, 5-1
	mov ecx, (18-5)+1
L2:
	inc eax
	call writeInt
	loop L2

;part d)Fill the aw2 with the elements a0=1, an=2(an-1 + 3).
	mov edi, OFFSET aw2
	mov ecx, LENGTHOF aw2
	mov eax, 1
	mov esi, 2
L3:
	mov [edi], eax
	add eax, 3
	mul esi
	add edi, TYPE aw1
	loop L3
	movzx ebx, aw2[2*2] ;should show 16h ('22') in EBX
	call dumpRegs

	exit
main ENDP
END main
