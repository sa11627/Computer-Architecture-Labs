    li x22, 0        
    li x24, 2           
    li x25, 0x200 
    li x11, 2            
    sw x11, 0(x25)      

Loop:
    slli x10, x22, 2     
    add  x10, x10, x25   
    lw   x9, 0(x10)      
    bne  x9, x24, Exit_Loop
    addi x22, x22, 1     
    beq  x0, x0, Loop

Exit_Loop:

end:
    j end