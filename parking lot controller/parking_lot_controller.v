module parking_lot_controller #(
    parameter TOTAL_SLOTS = 8
)(
    input  wire clk,
    input  wire reset,

    // Vehicle sensors
    input  wire entry_sensor,
    input  wire exit_sensor,

    // Outputs
    output reg entry_gate,
    output reg exit_gate,
    output reg full,
    output reg [3:0] available_slots
);

    reg [3:0] occupied_slots;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            occupied_slots <= 4'd0;
        end
        else begin

            // Vehicle enters
            if (entry_sensor && !exit_sensor) begin
                if (occupied_slots < TOTAL_SLOTS)
                    occupied_slots <= occupied_slots + 1'b1;
            end

            // Vehicle exits
            else if (exit_sensor && !entry_sensor) begin
                if (occupied_slots > 0)
                    occupied_slots <= occupied_slots - 1'b1;
            end
        end
    end

    // Available slot calculation
    always @(*) begin

        if (occupied_slots >= TOTAL_SLOTS)
            available_slots = 4'd0;
        else
            available_slots = TOTAL_SLOTS - occupied_slots;

        // Parking full indication
        if (occupied_slots >= TOTAL_SLOTS)
            full = 1'b1;
        else
            full = 1'b0;

        // Entry gate control
        if (entry_sensor && !full)
            entry_gate = 1'b1;
        else
            entry_gate = 1'b0;

        // Exit gate control
        if (exit_sensor)
            exit_gate = 1'b1;
        else
            exit_gate = 1'b0;
    end

endmodule
