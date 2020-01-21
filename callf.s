.globl	callfRaw, _callfRaw
# void callfRaw(void* _funcPtr, void* _pushData, size_t _pushSize, void* _popData, size_t _popType);
# popType
# 0: dword or lesser
# 1: qword
# 2: float
# 3: double
# 4: long double
_callfRaw:
callfRaw:
	pushl %ebp
	movl %esp, %ebp
	movl 12(%ebp), %edx
	movl 16(%ebp), %ecx
	shrl $2, %ecx
lp:
	movl (%edx), %eax
	pushl %eax
	addl $4, %edx
	loop lp
	movl 8(%ebp), %eax
	call *%eax
	movl %eax, %ecx
	movl 20(%ebp), %eax
	movl %eax, %ebx
	movl 24(%ebp), %eax
	cmpl $0, %eax
	jne retEAX
	cmp $1, %eax
	jne retEAXEDX
	cmp $2, %eax
	jne retFLOAT
	cmp $3, %eax
	jne retDOUBLE
	cmp $4, %eax
	jne retLDOUBLE
	jmp end
retEAXEDX:
	movl %edx, 4(%ebx)
retEAX:
	movl %ecx, (%ebx)
	jmp end
retFLOAT:
	fstps (%ebx)
	jmp end
retDOUBLE:
	fstpl (%ebx)
	jmp end
retLDOUBLE:
	fstpt (%ebx)
end:
	leave
	ret
