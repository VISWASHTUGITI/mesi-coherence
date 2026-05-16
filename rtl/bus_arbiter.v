// ============================================================
// Module : bus_arbiter
// Purpose: Round-robin arbitration for 2-core shared bus.
//          Holds grant until bus transaction completes.
//          Prevents starvation and bus conflicts.
// ============================================================

module bus_arbiter (
    input  wire       clk,
    input  wire       rst,

    input  wire [1:0] bus_req,    // one bit per core
    input  wire [1:0] bus_phase,  // from bus_interface

    output reg  [1:0] bus_grant   // one-hot grant
);

    localparam PHASE_IDLE = 2'b00;

    // Arbiter FSM
    localparam ARB_IDLE          = 2'b00;
    localparam ARB_GRANT         = 2'b01;
    localparam ARB_WAIT_COMPLETE = 2'b10;

    reg [1:0] arb_state;
    reg       last_granted;   // 0=core0 was last, 1=core1 was last
    reg       current_grant;

    wire bus_idle = (bus_phase == PHASE_IDLE);

    // Round-robin next grant
    wire rr_next  = last_granted ? 1'b0 : 1'b1; // alternate
    wire rr_valid = bus_req[rr_next];

    // If preferred candidate not requesting, try the other
    wire grant_sel = rr_valid ? rr_next : ~rr_next;
    wire any_req   = |bus_req;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            arb_state     <= ARB_IDLE;
            bus_grant     <= 2'b00;
            last_granted  <= 1'b0;
            current_grant <= 1'b0;
        end
        else begin
            case (arb_state)

                ARB_IDLE: begin
                    bus_grant <= 2'b00;
                    if (any_req) begin
                        current_grant <= grant_sel;
                        last_granted  <= grant_sel;
                        bus_grant     <= (grant_sel == 1'b0) ? 2'b01 : 2'b10;
                        arb_state     <= ARB_GRANT;

                        // synthesis translate_off
                        $display("[ARB] T=%0t | Grant → Core%0b",
                            $time, grant_sel);
                        // synthesis translate_on
                    end
                end

                ARB_GRANT: begin
                    // Give bus one cycle to register the grant
                    if (!bus_idle)
                        arb_state <= ARB_WAIT_COMPLETE;
                end

                ARB_WAIT_COMPLETE: begin
                    if (bus_idle) begin
                        bus_grant <= 2'b00;
                        arb_state <= ARB_IDLE;
                        // synthesis translate_off
                        $display("[ARB] T=%0t | Grant released (Core%0b)",
                            $time, current_grant);
                        // synthesis translate_on
                    end
                end

                default: arb_state <= ARB_IDLE;

            endcase
        end
    end

endmodule
