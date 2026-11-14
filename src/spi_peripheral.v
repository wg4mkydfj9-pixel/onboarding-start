module spi_peripheral (input SCLK, input COPI, input nCS, input clk ,input rst_n, output reg [7:0]en_reg_out, output reg [7:0] en_reg_out2, output reg [7:0]en_reg_pwm_7_0, output reg [7:0] en_reg_pwm_15_8, output reg [7:0] pwm_duty_cycle);
reg d;
reg sclk_synced;
reg d1;
reg COPI_synced;
reg d2;
reg nCS_synced;
reg sclk_past;
reg [15:0] bit_storage;
reg nCS_past;
reg [4:0] counter;

always @(posedge clk) begin
    if(rst_n == 0) begin
        d <= 0;
        sclk_synced <= 0;
    end else begin
    d <= SCLK;
    sclk_synced <= d;
    end
end
always @(posedge clk) begin
    if(rst_n == 0) begin
        d1 <= 0;
        COPI_synced <= 0;
    end else begin
    d1 <= COPI;
    COPI_synced <= d1;
    end
end
always @(posedge clk) begin
    if(rst_n == 0) begin
        d2 <= 1;
        nCS_synced <= 1;
    end else begin
    d2 <= nCS;
    nCS_synced <= d2;
    end
end

always @(posedge clk) begin
    if(rst_n == 0) begin
    sclk_past <= 0;
    nCS_past <= 1;
    bit_storage <= 0;
    counter <= 0;
    en_reg_out [7:0] <= 0;
    en_reg_out2 [7:0] <= 0;
    en_reg_pwm_7_0 [7:0] <= 0;
    en_reg_pwm_15_8 [7:0] <= 0;
    pwm_duty_cycle [7:0] <= 0;  
    end
    else begin
    if(nCS_synced == 0) begin

if(sclk_synced ==1 && sclk_past == 0) begin
    bit_storage[15 - counter] <= COPI_synced;
counter <= counter +1;
end
    end
    if(nCS_synced == 1 && nCS_past == 0) begin
        if(counter == 16) begin
        if(bit_storage[15] == 1) begin
case(bit_storage[14:8])
    7'h00: en_reg_out [7:0] <= bit_storage [7:0];
    7'h01: en_reg_out2 [7:0] <= bit_storage [7:0];
    7'h02: en_reg_pwm_7_0 [7:0] <= bit_storage [7:0];
    7'h03: en_reg_pwm_15_8 [7:0] <= bit_storage [7:0];
    7'h04: pwm_duty_cycle [7:0] <= bit_storage [7:0];  
endcase
        end
    end
    counter <= 0;
end
 sclk_past <= sclk_synced;
    nCS_past <= nCS_synced;
end 

end

endmodule


