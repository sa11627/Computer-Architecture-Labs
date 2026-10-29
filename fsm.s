# Lab 10: State-Based Control Flow Using RISC-V Assembly
# Target: RV32I, single-cycle processor, 10 MHz clock
# Memory-mapped I/O: LEDs=0x200, switches=0x300, reset=0x304
# The reset register (0x304) is an ADDITION to the Lab 8 interface.
# At 0x304: read 1 while the debounced reset is pressed; otherwise read 0.
# State: s3=0 waiting, s3=1 counting.
# Stack: initialized to 0xF0 (inside the 0x000-0x0FF RAM-select region).

    .section .text
    .globl _start
_start:
    addi sp, zero, 240          # stack starts at 0xF0
    addi s0, zero, 512          # LED address = 0x200
    addi s1, zero, 768          # switch address = 0x300; reset at +4
    addi s3, zero, 0            # STATE_WAIT
    sw   zero, 0(s0)            # LEDs = 0

wait_input:
    lw   t0, 4(s1)              # read reset input
    beq  t0, zero, read_switch
    sw   zero, 0(s0)            # keep LEDs off while reset pressed
    beq  zero, zero, wait_input

read_switch:
    lw   t0, 0(s1)              # read switch value
    beq  t0, zero, wait_input   # stay waiting while value == 0
    addi s3, zero, 1            # STATE_COUNTDOWN
    addi a0, t0, 0              # argument a0 = captured switch value
    jal  ra, countdown          # call countdown(a0)
    addi s3, zero, 0            # STATE_WAIT after completion/reset
    sw   zero, 0(s0)
    beq  zero, zero, wait_input

# countdown(initial_count): shows each count through zero.
# s4 is callee-saved; ra must survive the nested call to delay_step.
countdown:
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s4, 8(sp)
    addi s4, a0, 0

count_loop:
    lw   t0, 4(s1)              # reset check before displaying next count
    beq  t0, zero, show_count
    beq  zero, zero, abort_count

show_count:
    sw   s4, 0(s0)              # LEDs <- counter
    beq  s4, zero, finish_count
    jal  ra, delay_step         # delay_step returns a0 = 0 or 1
    beq  a0, zero, continue_count
    beq  zero, zero, abort_count

continue_count:
    addi s4, s4, -1
    beq  zero, zero, count_loop

abort_count:
    addi s4, zero, 0            # reset counter
    sw   zero, 0(s0)            # clear LEDs

finish_count:
    lw   s4, 8(sp)
    lw   ra, 12(sp)
    addi sp, sp, 16
    jalr zero, 0(ra)

# Approximately 1 second per count for a 10 MHz *single-cycle* CPU:
# around 5 instructions/iteration x 2,000,000 iterations = 10M cycles.
# Check reset on EVERY iteration; returns 1 on reset, else 0.
delay_step:
    addi sp, sp, -16
    sw   s5, 12(sp)
    lui  s5, 0x1e8             # 0x1e8000 = 1,998,848
    addi s5, s5, 1152          # s5 = 2,000,000

delay_loop:
    lw   t0, 4(s1)              # poll reset throughout delay
    beq  t0, zero, delay_tick
    addi a0, zero, 1            # reset requested
    beq  zero, zero, delay_exit

delay_tick:
    addi s5, s5, -1
    beq  s5, zero, delay_done
    beq  zero, zero, delay_loop

delay_done:
    addi a0, zero, 0            # successful delay

delay_exit:
    lw   s5, 12(sp)
    addi sp, sp, 16
    jalr zero, 0(ra)
