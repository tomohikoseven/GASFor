	.file	"main.c"
	.section	.rodata
.LC0:
	.string	"i = %d\n"          # printfのformat
	.text
	.globl	main                # mainは外部から呼び出し可能
	.type	main, @function     # mainは関数である
main:
.LFB0:
	.cfi_startproc              # main()の開始部分
	pushl	%ebp                # ベースポインタの値をスタックに積む
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp          # スタックポインタ=ベースポインタ
	.cfi_def_cfa_register 5
	andl	$-16, %esp          # スタックポインタを-16バイト移動させる
	subl	$32, %esp           # int i　のスタック領域確保
	movl	$0, 28(%esp)        # i = 0.
	movl	$0, 28(%esp)        # for文のi = 0.
	jmp	.L2                     # jump to .L2
.L3:
	movl	$.LC0, %eax     # eax = "i = %d\n"のポインタを代入
	movl	28(%esp), %edx  # edx = i
	movl	%edx, 4(%esp)   # i をesp+4(printf()の第2引数)部分へ代入
	movl	%eax, (%esp)    # esp = ("i = %d\n"のポインタ)を代入
	call	printf          # printf( %esp, 4(%esp) )
	addl	$1, 28(%esp)    # i++
.L2:                            # for文の条件判定部分
	cmpl	$1, 28(%esp)    # i と 1を比較(i < 2)
	jle	.L3                 # if i < 2, jmp to .L3(ループ処理)
	movl	$0, %eax        # mainの戻り値設定(eax = 0)
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu/Linaro 4.6.1-9ubuntu3) 4.6.1"
	.section	.note.GNU-stack,"",@progbits
