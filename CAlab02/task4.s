    li x5, 4
    li x6, 5      
    li x10, 0x100
    add x7, x0, x0       
out_loop:
    bge  x7, x5, out_end 
    add  x29, x0, x0    
in_loop:
    bge  x29, x6, in_end
    slli x28, x29, 4       
    add  x30, x10, x28     
    add  x31, x7, x29      
    sw   x31, 0(x30)     
    addi x29, x29, 1       
    j    in_loop
in_end:
    addi x7, x7, 1         
    j    out_loop
out_end:
end:
    j end 
