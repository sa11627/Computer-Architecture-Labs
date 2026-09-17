main:
    li   x10, 3              # n = 3 disks
    li   x11, 1                # from = peg 1
    li   x12, 3                # to = peg 3
    li   x13, 2                # via = peg 2
    li   x20, 0x200           
    sw   x0, 0(x20)              # initialize move counter to 0
    jal  x1, hanoi
    j    end
#hanoi(int n, int from, int to, int via)
#x10 = n, x11 = from, x12 = to, x13 = via
hanoi:
    beq  x10, x0, base_case     # if n=0 return
    addi sp, sp, -20           #store initial values in stack
    sw   x1, 16(sp)                
    sw   x10, 12(sp)             
    sw   x11, 8(sp)                
    sw   x12, 4(sp)
    sw   x13, 0(sp)
    #first recursive call: hanoi(n-1, from, via, to) 
    addi x10, x10, -1
    addi x5, x12, 0               # x5 = old "to"
    addi x12, x13, 0              # to = via
    addi x13, x5, 0               # via = old to
    jal  x1, hanoi          
    #original values restored before doing the move
    lw   x10, 12(sp)
    lw   x11, 8(sp)
    lw   x12, 4(sp)
    lw   x13, 0(sp)
    #move one disk from 'from' to 'to'
    li   x20, 0x200
    lw   x21, 0(x20)
    addi x21, x21, 1
    sw   x21, 0(x20)
    #second recursive call: hanoi(n-1, via, to, from)
    addi x10, x10, -1
    addi x6, x11, 0               # x6 = old "from"
    addi x11, x13, 0              # from = via
    addi x13, x6, 0               # via = old from
    jal  x1, hanoi             
    lw   x1, 16(sp)
    addi sp, sp, 20
    ret
base_case:
    jalr x0, 0(x1)
end:
    j end



#int moveCount = 0;

#void hanoi(int n, int from, int to, int via) {
    ##if (n == 0)
        #return;
    #hanoi(n - 1, from, via, to);   // move n-1 disks out of the way
    #moveCount++;                   // "move" the remaining disk from -> to
    #hanoi(n - 1, via, to, from);   // move n-1 disks back on top
#}

#int main() {
    #hanoi(3, 1, 3, 2);   // move 3 disks from peg 1 to peg 3, using peg 2 as spare
    #return moveCount;     // should be 2^3 - 1 = 7
#}