module gen_freq(
    input wire clk,           // Reloj de 25 MHz
    input wire btn0,          // Pulsador en 9 (con pull-up)
    input wire btn1,          // Pulsador en 10 (con pull-up)
    input wire btn2,          // Pulsador en 15 (con pull-up)
    input wire btn3,          // Pulsador en 16 (con pull-up)
    input wire btn4,          // Pulsador en 11 (con pull-up)
    input wire btn5,          // Pulsador en 12 (con pull-up)
    input wire btn6,          // Pulsador en 17 (con pull-up)
    
    output reg salida_C,      // Señal de salida para Do
    output reg salida_D,      // Señal de salida para Re
    output reg salida_E,      // Señal de salida para Mi
    output reg salida_F,      // Señal de salida para Fa
    output reg salida_G,      // Señal de salida para Sol
    output reg salida_A,      // Señal de salida para La
    output reg salida_B       // Señal de salida para Si
);

    // Frecuencias deseadas (divisores para el reloj de 25 MHz)
    parameter DIV_C = 47778;  // Para Do (261.63 Hz)
    parameter DIV_D = 42610;  // Para Re (293.66 Hz)
    parameter DIV_E = 37919;  // Para Mi (329.63 Hz)
    parameter DIV_F = 35816;  // Para Fa (349.23 Hz)
    parameter DIV_G = 31888;  // Para Sol (392.00 Hz)
    parameter DIV_A = 28409;  // Para La (440.00 Hz)
    parameter DIV_B = 25310;  // Para Si (493.88 Hz)

    reg [15:0] contador_C = 0;
    reg [15:0] contador_D = 0;
    reg [15:0] contador_E = 0;
    reg [15:0] contador_F = 0;
    reg [15:0] contador_G = 0;
    reg [15:0] contador_A = 0;
    reg [15:0] contador_B = 0;
    reg estado_salida_C = 0;
    reg estado_salida_D = 0;
    reg estado_salida_E = 0;
    reg estado_salida_F = 0;
    reg estado_salida_G = 0;
    reg estado_salida_A = 0;
    reg estado_salida_B = 0;

    always @(posedge clk) begin
        // Asignar el divisor basado en el botón presionado (activos en bajo)
        if (~btn0) begin
            // Generar señal para Do
            if (contador_C >= DIV_C) begin
                contador_C <= 0;
                estado_salida_C <= ~estado_salida_C;
            end else begin
                contador_C <= contador_C + 1;
            end
        end else begin
            contador_C <= 0;
        end

        if (~btn1) begin
            // Generar señal para Re
            if (contador_D >= DIV_D) begin
                contador_D <= 0;
                estado_salida_D <= ~estado_salida_D;
            end else begin
                contador_D <= contador_D + 1;
            end
        end else begin
            contador_D <= 0;
        end

        if (~btn2) begin
            // Generar señal para Mi
            if (contador_E >= DIV_E) begin
                contador_E <= 0;
                estado_salida_E <= ~estado_salida_E;
            end else begin
                contador_E <= contador_E + 1;
            end
        end else begin
            contador_E <= 0;
        end

        if (~btn3) begin
            // Generar señal para Fa
            if (contador_F >= DIV_F) begin
                contador_F <= 0;
                estado_salida_F <= ~estado_salida_F;
            end else begin
                contador_F <= contador_F + 1;
            end
        end else begin
            contador_F <= 0;
        end

        if (~btn4) begin
            // Generar señal para Sol
            if (contador_G >= DIV_G) begin
                contador_G <= 0;
                estado_salida_G <= ~estado_salida_G;
            end else begin
                contador_G <= contador_G + 1;
            end
        end else begin
            contador_G <= 0;
        end

        if (~btn5) begin
            // Generar señal para La
            if (contador_A >= DIV_A) begin
                contador_A <= 0;
                estado_salida_A <= ~estado_salida_A;
            end else begin
                contador_A <= contador_A + 1;
            end
        end else begin
            contador_A <= 0;
        end

        if (~btn6) begin
            // Generar señal para Si
            if (contador_B >= DIV_B) begin
                contador_B <= 0;
                estado_salida_B <= ~estado_salida_B;
            end else begin
                contador_B <= contador_B + 1;
            end
        end else begin
            contador_B <= 0;
        end
    end

    // Asignar las salidas generadas
    always @(*) begin
        salida_C = estado_salida_C;
        salida_D = estado_salida_D;
        salida_E = estado_salida_E;
        salida_F = estado_salida_F;
        salida_G = estado_salida_G;
        salida_A = estado_salida_A;
        salida_B = estado_salida_B;
    end

endmodule
