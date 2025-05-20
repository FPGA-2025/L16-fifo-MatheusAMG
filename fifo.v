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

reg [7:0] fila_fifo [0:3]; 

reg [1:0] wr_pointer; //ponteiro de escrita contador
reg [1:0] rd_pointer; //ponteiro de leitura

//Lógica combinacional
assign full  = (((wr_pointer + 1) == rd_pointer) || (wr_pointer == 3 && rd_pointer == 0));
assign empty = (wr_pointer == rd_pointer);

//Lógica contador write
always @(posedge clk, negedge rstn) begin
    if(~rstn)begin
        wr_pointer <= 0;
    end
    else begin
        if (~full && wr_en) begin
            fila_fifo[wr_pointer] <= data_in;
            // if (wr_pointer == 3) begin
            //     wr_pointer <= 0;
            // end
            // else begin
            //     wr_pointer <= wr_pointer + 1;
            // end
            wr_pointer <= wr_pointer + 1;
        end
    end
end

//Lógica contador read
always @(posedge clk, negedge rstn) begin
    if(~rstn)begin
        rd_pointer <= 0;
    end
    else begin
        if (~empty && rd_en) begin
            data_out <= fila_fifo[rd_pointer];
            // if (rd_pointer == 3) begin
            //     rd_pointer <= 0;
            // end
            // else begin
            //     rd_pointer <= rd_pointer + 1;
            // end
            rd_pointer <= rd_pointer + 1;
        end
    end
end

endmodule

