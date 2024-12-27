module flow_led (
    input sys_clk,        // 系统时钟
    input sys_res_n,      // 系统复位，低电平有效
    output reg [3:0] led  // 4个LED灯
);

//reg define
reg [23:0] counter;

//***********************************
//**         main code
//***********************************

// 计数器对系统时钟计数，计数0.2秒
always @(posedge sys_clk or negedge sys_res_n) begin
    if (!sys_res_n)
        counter <= 24'd0;
    else if (counter < 24'd10)
        counter <= counter + 1'b1;
    else
        counter <= 24'd0;
end

// 通过位移寄存器控制IO口的高低电平，从而改变LED灯的显示状态
always @(posedge sys_clk or negedge sys_res_n) begin
    if (!sys_res_n)
        led <= 4'b0001;
    else if (counter == 24'd10) begin
        led <= {led[2:0], led[3]}; // 使用非阻塞赋值
    end
end

endmodule