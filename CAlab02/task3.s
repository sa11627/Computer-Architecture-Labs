    li   x21, 0x200      
    add  x23, x0, x0  
    add  x22, x0, x0       
    li   x5, 10         

loop1:
    bge  x22, x5, loop1_end
    slli x6, x22, 2      
    add  x7, x21, x6       
    sw   x22, 0(x7)    
    addi x22, x22, 1   
    j    loop1
loop1_end:
add  x22, x0, x0          
loop2:
    bge  x22, x5, loop2_end
    slli x6, x22, 2      
    add  x7, x21, x6    
    lw   x28, 0(x7)      
    add  x23, x23, x28     
    addi x22, x22, 1       
    j    loop2
loop2_end:
end:
    j end 

