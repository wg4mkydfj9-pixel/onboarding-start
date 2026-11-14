module spi_peripheral (input SCLK, input COPI, nCS, input clk ,input rst_n, output [7:0]en_reg_out, output [15:8] en_reg_out2, output [7:0]en_reg_pwm_7_0, output [15:8] en_reg_pwm_15_8, output [7:0] pwm_duty_cycle);
reg d;
reg sclk_synced;
reg d1;
reg COPI_synced;
reg d2;
reg nCS_synced;
reg sclk_past = 0;
reg [15:0] bit_storage;

integer counter = 0;
always @(posedge clk) begin
    d <= SCLK;
    sclk_synced <= d;
end
always @(posedge clk) begin
    d1 <= COPI;
    COPI_synced <= d1;
end
always @(posedge clk) begin
    d2 <= nCS;
    nCS_synced <= d2;
end

always @(posedge clk) begin
    while(!nCS_synced) begin
counter = 0;
if(sclk_synced ==1 && sclk_past == 0) begin
    bit_storage[counter] = COPI_synced;
counter = counter +1;
sclk_past = sclk_synced;
end
    end
    if(nCS_synced == 1) begin
case(bit_storage[14:8])
    
endcase

    end
end



endmodule


