module boot_rom_generic #(
  parameter ABITS      = 10,
  parameter DBITS      = 32,
  parameter INIT_MEMORY= 0,
  parameter INIT_FILE  = ""
)
(
  input                        rst_ni,
  input                        clk_i,

  //Write side
  input      [ ABITS     -1:0] waddr_i,
  input      [ DBITS     -1:0] din_i,
  input                        we_i,
  input      [(DBITS+7)/8-1:0] be_i,

  //Read side
  input      [ ABITS     -1:0] raddr_i,
  output reg [ DBITS     -1:0] dout_o
);
  (* ram_style = "block" *) reg [DBITS-1:0] mem_array [2**ABITS -1:0];  //memory array

  always @(posedge clk_i)
    dout_o <= mem_array[ raddr_i ];


  initial begin
    if (INIT_MEMORY) begin
      $readmemh(INIT_FILE, mem_array);
    end
  end
endmodule


