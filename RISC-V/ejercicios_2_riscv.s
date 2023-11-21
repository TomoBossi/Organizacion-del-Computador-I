.text:
    la a0, src
    la a1, dst
    call or_384bit

imprimir:
    la t2, dst
    # Cantidad de datos.
    li t3, 12
loop_imprimir:
    beqz t3, exit
    addi t3, t3, -1
    lw t4, 0(t2)
    # Imprime el resultado
    mv a0, t4
    li a7, 34
    ecall
    addi t2, t2, 4

    j loop_imprimir
exit:
    # Termina el programa.
    li a0, 0
    li a7, 93
    ecall

or_384bit:
    li t0, 12 # cantidad de elementos hardcodeada
    loop_or_384bit:
        beqz t0, return_or_384bit
        lw t1, 0(a0) # carga en t1 el elemento siguiente del vector src
        lw t2, 0(a1) # carga en t2 el elemento siguiente del vector dst
        or t2, t1, t2 # realiza el or y guarda el resultado en t2
        sw t2, 0(a1) # sobreescribe el elemento de dst con el resultado del or
        addi a0, a0, 4 # incrementa la posición de memoria en 4 para pasar al próximo elemento del vector src
        addi a1, a1, 4 # incrementa la posición de memoria en 4 para pasar al próximo elemento del vector dst
        addi t0, t0, -1 # decrementa el contador de elementos 
        j loop_or_384bit
    return_or_384bit:
    ret

.data:
src:
.word 0xffffffff, 0x95555555, 0xf4444444, 0xf1111111
.word 0xffffff00, 0xf5005555, 0x95444444, 0xf1113311
.word 0xff00ffff, 0xf5550055, 0xa4444433, 0xa1551111      
dst:
.word 0xf5005555, 0x95444444, 0xf1113311, 0xffffff00
.word 0xf1111111, 0xffffffff, 0x95555555, 0xf4444444
.word 0xa1551111, 0xff00ffff, 0xf5550055, 0xa4444433
