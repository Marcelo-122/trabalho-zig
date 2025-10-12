// src/main.zig --> pra rodar só colocar zig build run
const std = @import("std");
const builtin = @import("builtin");
const native_arch = builtin.cpu.arch;
const expect = std.testing.expect;

fn somar(a: i32, b: i32) i32 {
    return a + b;
}

fn multiplicar(a: i32, b: i32) i32 {
    return a * b;
}

// O terceiro parâmetro 'operacao' é um ponteiro para uma função que recebe (i32, i32) 
// e retorna i32.
fn executarOperacao(a: i32, b: i32, operacao: *const fn (i32, i32) i32) i32 {
    std.debug.print("Executando a operação...\n", .{});
    // Chama a função passada como parâmetro
    const resultado = operacao(a, b);
    return resultado;
}

pub fn main() void {
    const num1: i32 = 10;
    const num2: i32 = 5;

    // Passamos a função 'somar' como parâmetro. Note o '&' para pegar o endereço.
    const resultadoSoma = executarOperacao(num1, num2, &somar);
    std.debug.print("Resultado da soma: {}\n", .{resultadoSoma});

    // Agora, passamos a função 'multiplicar'.
    const resultadoMult = executarOperacao(num1, num2, &multiplicar);
    std.debug.print("Resultado da multiplicação: {}\n", .{resultadoMult});
}
