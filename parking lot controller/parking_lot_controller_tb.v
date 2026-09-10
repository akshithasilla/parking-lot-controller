`timescale 1ns/1ps

module tb_parking_lot_controller;

    parameter TOTAL_SLOTS = 4;

    reg clk;
    reg reset;
    reg entry_sensor;
    reg exit_sensor;

    wire entry_gate;
    wire exit_gate;
    wire full;
    wire [3:0] available_slots;

    // DUT
    parking_lot_controller #(
        .TOTAL_SLOTS(TOTAL_SLOTS)
    ) uut (
        .clk(clk),
        .reset(reset),
        .entry_sensor(entry_sensor),
        .exit_sensor(exit_sensor),
        .entry_gate(entry_gate),
        .exit_gate(exit_gate),
        .full(full),
        .available_slots(available_slots)
    );

    // 10 ns clock
    always #5 clk = ~clk;

    initial begin

        clk = 0;
        reset = 1;
        entry_sensor = 0;
        exit_sensor = 0;

        // Reset
        #20;
        reset = 0;

        // Vehicle 1 enters
        #10;
        entry_sensor = 1;
        #10;
        entry_sensor = 0;

        // Vehicle 2 enters
        #20;
        entry_sensor = 1;
        #10;
        entry_sensor = 0;

        // Vehicle 3 enters
        #20;
        entry_sensor = 1;
        #10;
        entry_sensor = 0;

        // Vehicle 4 enters
        #20;
        entry_sensor = 1;
        #10;
        entry_sensor = 0;

        // Parking lot should now be FULL

        // Vehicle exits
        #20;
        exit_sensor = 1;
        #10;
        exit_sensor = 0;

        // Another vehicle enters
        #20;
        entry_sensor = 1;
        #10;
        entry_sensor = 0;

        // Reset
        #20;
        reset = 1;
        #10;
        reset = 0;

        #20;

        $finish;
    end

    // Display simulation results
    initial begin
        $monitor(
            "Time=%0t | Entry=%b | Exit=%b | Occupied=%0d | Available=%0d | EntryGate=%b | ExitGate=%b | FULL=%b",
            $time,
            entry_sensor,
            exit_sensor,
            TOTAL_SLOTS - available_slots,
            available_slots,
            entry_gate,
            exit_gate,
            full
        );
    end

endmodule
