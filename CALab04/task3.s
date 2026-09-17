main:
    li   x10, 0x100      
    li   x11, 5        
    li   x5, 5
    sw   x5, 0(x10)
    li   x5, 2
    sw   x5, 4(x10)
    li   x5, 8
    sw   x5, 8(x10)
    li   x5, 10
    sw   x5, 12(x10)
    li   x5, 1
    sw   x5, 16(x10)
    addi x11, x0, 5         # len = 5
    jal  x1, bubble
    j    end
bubble:
    addi sp, sp, -20
    sw   x1, 16(sp)
    sw   x8, 12(sp)
    sw   x9, 8(sp)
    sw   x18, 4(sp)
    sw   x19, 0(sp)
    addi x8, x10, 0          # x8 = a
    addi x9, x11, 0          # x9 = len
    li   x18, 0              # i = 0
outer:
    bge  x18, x9, end_outer  # if (i >= len) exit outer loop
    addi x19, x18, 0         # j = i
inner:
    bge  x19, x9, end_inner  # if (j >= len) exit inner loop
    slli x5, x18, 2
    add  x5, x8, x5          # x5 = a[i]
    lw   x7, 0(x5)            # x7 = a[i]
    slli x6, x19, 2
    add  x6, x8, x6           # x6 = a[j]
    lw   x28, 0(x6)            # x28 = a[j]
    bge  x7, x28, no_swap      # skip if a[i] >= a[j]
    sw   x28, 0(x5)            # a[i] = a[j]
    sw   x7, 0(x6)             # a[j] = old a[i]
no_swap:
    addi x19, x19, 1
    j    inner
end_inner:
    addi x18, x18, 1
    j    outer
end_outer:
    lw   x1, 16(sp)
    lw   x8, 12(sp)
    lw   x9, 8(sp)
    lw   x18, 4(sp)
    lw   x19, 0(sp)
    addi sp, sp, 20
    jalr x0, 0(x1)
end:
    j end