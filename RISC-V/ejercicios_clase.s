.text:
main:
    # li a0, 7
    # li a1, 6
    # call son_pares
    
    # la a0, vector
    # li a1, 6
    # call contar_pares
    
    li a0, 5
    call n_sum
halt:
    j halt


# función recursiva, necesidad de call stack
# push a la pila: actualizar sp a sp-16, pushear (store) valor de 32 bits al nuevo sp
# pop de la pila: poppear (load) los valores, actualizar sp a sp+16
# convencion pide que sp (y el bloque "pedidos") sea divisible por 16
# solución Joni
n_sum: # n_sum(n)
    beqz a0, return_n_sum
    
    addi sp, sp, -16 # sp ya viene inicializado en un lugar alto de memoria
    sw ra, 0(sp)
    sw a0, 4(sp)
    # si hubiese tenido más parámetros:
    # sw a1, 8(sp)
    # sw a2, 12(sp)
    # sw a3, 16(sp) # tendría que haber pedido 32 bytes al decrementar sp, no 16
    
    addi a0, a0, -1
    call n_sum # llamado recursivo
    
    lw ra, 0(sp)
    lw a1, 4(sp) # no puedo usar a0 acá porque pisaría el resultado de n_sum  
    addi sp, sp, 16  
    
    add a0, a0, a1 # a0 = resultado de llamado recursivo, a1 = n del llamado actual, recuperado de la pila
    
    return_n_sum:
        ret # implicitamente a0 == 0
        

contar_pares: # contar_pares(vector, longitud)
    mv s0, ra # preservamos el return a main
    
    mv s1, a0 # copiamos la direccion en la que comienza el vector
    mv s2, a1 # copiamos la longitud del vector
    mv s3, x0 # inicializamos el resultado en 0
    
    loop_contar_pares:
        lw a0, 0(s1) # cargamos a a0 el elemento correspondiente del vector
        call es_par # vemos si es par o no
        add s3, s3, a0 # sumamos el resultado de es_par a s3, acumulando el resultado
        addi s1, s1, 4 # incrementamos la posición de memoria en 4 para pasar al próximo elemento del vector
        addi s2, s2, -1 # decrementamos el contador de elementos 
        bnez s2, loop_contar_pares # si siguen quedando elementos sin chequear, se sigue iterando
    
    mv a0, s3 # mueve el resultado a a0, por convención
    mv ra, s0 # recupera el return adress a main
    ret # vuelve a main


# solución Joni
# contar_pares:
#    mv s0, a0
#    mv s1, a1
#    mv s2, ra
#    li s3, 0
#    loop_contar_pares:
#        beqz s1, return_contar_pares # esto es mejor que lo que hicimos arriba, porque funciona para vectores vacios
#        addi s1, s1, -1
#        lw a0, 0(s0)
#        addi s0, s0, 4
#        call es_par
#        add s3, s3, a0
#        j loop_contar_pares
#    return_contar_pares:
#        mv a0, s3
#        mv ra, s2
#        ret


es_par: # es_par(n)
    # suponemos que nos llega n en a0. Miramos bit menos significativo del registro
    andi a0, a0, 1
    xori a0, a0, 1
    ret # el valor de retorno queda en a0, sobreescribiendo al parámetro de entrada

    
son_pares: # son_pares(n1, n2)
    # suponemos que nos llega n1 en a0, n2 en a1
    # es_par(n1) and es_par(n2)
    
    # si arrancamos haciendo
    # call es_par
    # perdemos ra de son_pares para volver a main
    
    mv s0, ra # ahora s0 guarda el ra a main
    mv s1, a1 # preservamos a1 (en principio es_par podría modificarlo)
    call es_par # es_par(n1)
    

    mv s2, a0 # preservamos el output del primero llamado a es_par    
    mv a0, s1 # restauramos el input a1 para usarlo en es_par
    call es_par # es_par(n2) 
    
    # es_par(n1) = s2
    # es_par(n2) = a0
    and a0, a0, s2 # guardamos el output final en a0
    
    mv ra, s0 # restauramos el ra para poder usar ret al final
    ret

    
.data:
vector: .word 40, 8, 7, 6, 6, 4