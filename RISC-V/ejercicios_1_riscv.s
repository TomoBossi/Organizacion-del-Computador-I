.text:
main:
    la a0, arr
    call sumar_pares

exit:
    # Imprime la suma
    li a7, 34
    ecall

    # Termina el programa
    li a0, 0
    li a7, 93
    ecall

es_par: # a0 = if (old(a0)%2 == 0) then 1 else 0
    andi a0, a0, 1
    xori a0, a0, 1
    ret

sumar_pares:
    mv s0, ra # return address
    mv s1, a0 # posicion en memoria del vector
    li s2, 12 # cantidad de elementos hardcodeada
    mv s3, x0 # resultado inicializado en 0
    loop_sumar_pares:
        beqz s2, return_sumar_pares
        lw a0, 0(s1) # carga en a0 el elemento siguiente del vector
        mv s4, a0 # guarda el valor del elemento
        call es_par # chequeo de paridad
        beqz a0, elemento_impar # si el elemento es impar, no se lo suma (la próxima instrucción es salteada)
        add s3, s3, s4 # suma el elemento a s3, acumulando el resultado
        elemento_impar:
        addi s1, s1, 4 # incrementa la posición de memoria en 4 para pasar al próximo elemento del vector
        addi s2, s2, -1 # decrementa el contador de elementos 
        j loop_sumar_pares
    return_sumar_pares:
    mv a0, s3 # mueve el resultado a a0, por convención
    mv ra, s0 # recupera el return address a main
    ret # vuelve a main

.data:
arr: # 0x44444444 + 0x55444444 + 0xffffff00 = 0x99888788
.word 0xffffffff, 0x55555555, 0x44444444, 0x11111111
.word 0xffffff00, 0x55005555, 0x55444444, 0x11113311
.word 0xff00ffff, 0x55550055, 0x44444433, 0x11551111
