    li x1, 5
    add x2, x0, x0
    addi x1, x2, 32
    add x3, x1, x2
    addi x4, x3, -5
    sub x6, x1, x4
    sub x7, x2, x1
    add x8, x6, x7
    add x5, x8, x4
    add x9, x4, x5
    add x5, x3, x9
end:
    j end
