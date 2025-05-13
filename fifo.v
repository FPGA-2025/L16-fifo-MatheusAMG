module fifo(
    input wire clk,
    input wire rstn,
    input wire wr_en,
    input wire rd_en,
    input wire [7:0] data_in,
    output reg [7:0] data_out,
    output full,
    output empty
);

reg [7:0] fila_fifo [3:0]; //declarar 4 registradores de 8 bits
reg [1:0] pt_wr; //ponteiro de escrita
reg [1:0] pt_rd; //ponteiro de leitura
reg [4:0] counter;

assign full  = (counter == 4);
assign empty = (counter == 0);

// pode entrar e sair dados ao mesmo tempo
always @(posedge clk, negedge rstn) begin
    if(~rstn) begin
        pt_wr <=0;
        pt_rd <=0;
        counter <= 0;
    end
    else begin
        if(wr_en && ~full)begin
            fila_fifo[pt_wr] <= data_in;
            pt_wr <= (pt_wr == 3) ? 0 : pt_wr + 1;
            counter <= counter + 1;
        end
        if(rd_en && ~empty)begin
            data_out <= fila_fifo[pt_rd];
            pt_rd <= (pt_rd == 3) ? 0 : pt_rd + 1;
            counter <= counter - 1;
        end
    end
end

endmodule

