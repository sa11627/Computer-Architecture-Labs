addi x10, x0, 5
addi x5, x0, 1
jal x1, loop
j end 
loop:
    bge x0, x10, done
    mul x5, x5, x10
    addi x10, x10, -1
    j loop
done:
    addi x10, x5, 0
    jalr x0, 0(x1)
end:
    j end

