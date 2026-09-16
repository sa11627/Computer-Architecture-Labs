    li x10, 10       #loading test values 
    li x11, 11
    li x12, 12
    li x13, 13

    addi sp, sp, -12     #stack pointer goes 12 bytes
                         #up to store values
    sw x18, 8(sp)        #pushing values in the stack
    sw x19, 4(sp)
    sw x20, 0(sp)

    jal x1, leaf_example     #jumps to leaf_example function

    add x11, x0, x10         #store x10 value in x11 and prints 46
    li x10, 1

    ecall 
    j end

leaf_example:
    lw x20, 0(sp)           #pops values from stack
    lw x19, 4(sp)
    lw x18, 8(sp)
    addi sp, sp, 12         #restore the pointer

    add x18, x10, x11       #adds 10 and 11
    add x19, x12, x13       #adds 12 and 13
    add x20, x18, x19       #adds 21 and 25

    add x10, x0, x20       #stores 46 in x10

    jalr x0, 0(x1)

end:
    j end