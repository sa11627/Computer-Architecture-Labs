// Lab 10 - Instruction Memory for a byte-addressed RV32I processor
// 256 bytes = 64 32-bit instructions. The FSM uses 208 bytes (52 instructions).
// RV32I instructions are stored little-endian: byte at PC is least significant.

module instructionMemory #(
    parameter OPERAND_LENGTH = 31
)(
    input  [OPERAND_LENGTH:0] instAddress,
    output reg [31:0] instruction
);
    reg [7:0] memory [0:255];

    initial begin
        $readmemh("fsm_bytes.hex", memory);
    end

    always @(*) begin
        if ((instAddress <= 32'd252) && (instAddress[1:0] == 2'b00)) begin
            instruction = {
                memory[instAddress + 3],
                memory[instAddress + 2],
                memory[instAddress + 1],
                memory[instAddress]
            };
        end else begin
            instruction = 32'h00000013; // NOP: invalid/out-of-range PC
        end
    end
endmodule
