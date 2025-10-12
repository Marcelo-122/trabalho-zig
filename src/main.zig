// src/main.zig --> pra rodar só colocar zig build run
const std = @import("std");
const parte1 = @import("parte1.zig");
const builtin = @import("builtin");
const native_arch = builtin.cpu.arch;
const expect = std.testing.expect;

pub fn main() void {
    const num1: i32 = 10;
    const num2: i32 = 5;
    // Parte 1
    // Passamos a função 'somar' como parâmetro. Note o '&' para pegar o endereço.
    const resultadoSoma = parte1.executarOperacao(num1, num2, &parte1.somar);
    std.debug.print("Resultado da soma: {}\n", .{resultadoSoma});

    // Agora, passamos a função 'multiplicar'.
    const resultadoMult = parte1.executarOperacao(num1, num2, &parte1.multiplicar);
    std.debug.print("Resultado da multiplicação: {}\n", .{resultadoMult});
    
    // Parte 2
}
