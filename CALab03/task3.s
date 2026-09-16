    li x10, 0x100        #base address
    li x11, 0            
    li x5, 10
    sw x5, 0(x10)        #storing 10 in 0x100
    li x5, 20
    sw x5, 4(x10)       #storing 20 in 0x104

    jal x1, swap
    j end

swap:
    slli x6, x11, 2      #shifts left by 4
    add  x6, x10, x6     #stores address of current value

    lw   x5, 0(x6)       #loads current value
    lw   x7, 4(x6)       #loads next value in temporary register 

    sw   x7, 0(x6)      #puts temporary value in first address
    sw   x5, 4(x6)       #puts current value at temp address

    jalr x0, 0(x1)     

end:
    j end