    addi x5, x0, 0x100
    addi x6, x0, 0x200
    addi x7, x0, 0x300

    #a values
    li x1, 1
    sb x1, 0(x5)
    li x1, 2
    sb x1, 1(x5)
    li x1, 3
    sb x1, 2(x5)
    li x1, 4
    sb x1, 3(x5)

    #b values
    li x1, 5
    sh x1, 0(x6)
    li x1, 6
    sh x1, 2(x6)
    li x1, 7
    sh x1, 4(x6)
    li x1, 8
    sh x1, 6(x6)

    #i = 0
    lb   x28, 0(x5)         
    lh   x29, 0(x6)        
    add  x30, x28, x29     
    sw   x30, 0(x7)         

    #i = 1
    lb   x28, 1(x5)         
    lh   x29, 2(x6)         
    add  x30, x28, x29     
    sw   x30, 4(x7)         

    #i = 2
    lb   x28, 2(x5)         
    lh   x29, 4(x6)         
    add  x30, x28, x29      
    sw   x30, 8(x7)         

    #i = 3
    lb   x28, 3(x5)         
    lh   x29, 6(x6)         
    add  x30, x28, x29      
    sw   x30, 12(x7)        
end:
    j end    
