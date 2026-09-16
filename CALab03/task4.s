    li x11, 0x200        #base address
    li x5, 'H'           #store ASCII values in memory
    sb x5, 0(x11)
    li x5, 'I'
    sb x5, 1(x11)
    sb x0, 2(x11)        
    li x10, 0x300        #destination address
    jal x1, strcpy
    j end
strcpy:
    addi sp, sp, -8       #reserves 8 bytes in stack
    add x19, x0, x0       #i=0
L1:
    add x5, x11, x19     #base address+offset i
    lbu x6, 0(x5)        #load it into x6
    add x7, x10, x19     #base address of destination+i
    sb x6, 0(x7)         #store x6 at that address
    
    beq x6, x0, L2      #check if byte=0 or not

    addi x19, x19, 1    #byte!=0, i++
    jal x0, L1          #loop runs again
L2:     
    addi sp, sp, 8
    jalr x0, 0(x1)      #if byte=0, break the loop

end:
    j end