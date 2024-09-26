`include "./clk10hz.v"
`include "./counter8bits.v"
`include "./dual_port_ram.v"
`include "./gen_freq.v"

module top (
    input clk,
    input btn, // ENTRADA DEL BOTÓN (con pull-up)
    output [7:0] leds,
    output [7:0] sounds,
    input [7:0] btn_in
);

  wire clk2;
  reg [7:0] runner; // Cambiar de wire a reg para controlar el contador manualmente

`ifndef SIM
  clk10hz clock (
      .clk_in (clk),
      .clk_out(clk2)
  );
`else
  assign clk2 = clk;
`endif

  reg write_enable_A = 0;
  reg write_enable_B = 0;
  reg [7:0] data_in_A = 0;
  reg [7:0] data_in_B = 0;
  reg [7:0] address_A;
  reg [7:0] address_B = 0;
  wire [7:0] data_out_B;
  
  wire [7:0] data_out;
  wire [7:0] data_outL;

  dual_port_ram ram0 (
      .clock(clk2),
      .write_enable_A(write_enable_A),
      .write_enable_B(write_enable_B),
      .data_in_A(data_in_A),
      .data_in_B(data_in_B),
      .address_A(address_A), 
      .address_B(address_B),
      .data_out_A(data_out),
      .data_out_B(data_out_B)
  );

  // Detectar el flanco de bajada del botón (pull-up: 1 cuando no está presionado, 0 cuando presionado)
  reg btn_prev = 1;
  wire btn_falling_edge = (btn_prev == 1) && (btn == 0); // Detectar cuando pasa de 1 a 0 (presionado)

  // Señal para iniciar la lectura
  reg start = 0;

  // Variable para saber si el ciclo se ha completado
  reg cycle_done = 0;

  always @(posedge clk2) begin
    btn_prev <= btn; // Almacenar el estado previo del botón

    // Si se detecta un flanco de bajada, iniciar el ciclo si no está en progreso
    if (btn_falling_edge && !start && !cycle_done) begin
      start <= 1;        // Iniciar el recorrido
      runner <= 5'b0;    // Reiniciar el contador
    end

    // Si se ha iniciado el recorrido
    if (start) begin
      address_A <= runner; // Usar el valor de runner como dirección de la memoria
      runner <= runner + 1; // Incrementar el contador manualmente

      if (runner == 5'h10) begin // Cuando se alcanza el final del contador (8'hFF es el valor máximo del contador)
        start <= 0;       // Detener el recorrido
        cycle_done <= 1;  // Marcar que se completó el ciclo
      end
    end
  end

  // Lógica para resetear el ciclo completado
  always @(posedge clk2) begin
    if (btn_falling_edge && cycle_done) begin
      cycle_done <= 0; // Permitir que se inicie un nuevo ciclo al presionar el botón de nuevo
    end
  end
	
	assign leds = gen_in;
	
	wire [7:0] gen_in;
	assign gen_in = btn_in & ~data_out;
	

  gen_freq gen_freq (
	  .clk(clk),
	  .btn0(gen_in[0]),
	  .btn1(gen_in[1]),
	  .btn2(gen_in[2]),
	  .btn3(gen_in[3]),
	  .btn4(gen_in[4]),
	  .btn5(gen_in[5]),
	  .btn6(gen_in[6]),
	  .salida_C(sounds[0]),
	  .salida_D(sounds[1]),
	  .salida_E(sounds[2]),
	  .salida_F(sounds[3]),
	  .salida_G(sounds[4]),
	  .salida_A(sounds[5]),
	  .salida_B(sounds[6])
  );
  
endmodule
