// src/main.zig --> pra rodar só colocar zig build run
const std = @import("std");
const parte1 = @import("parte1.zig");
const parte2 = @import("parte2.zig");
const builtin = @import("builtin");
const native_arch = builtin.cpu.arch;
const expect = std.testing.expect;

pub fn main() void {
    const num1: i32 = 10;
    const num2: i32 = 5;
    // Parte 1
    std.debug.print("Parte 1\n: ", .{});
    // Passamos a função 'somar' como parâmetro. Note o '&' para pegar o endereço.
    const resultadoSoma = parte1.executarOperacao(num1, num2, &parte1.somar);
    std.debug.print("Resultado da soma: {}\n", .{resultadoSoma});

    // Agora, passamos a função 'multiplicar'.
    const resultadoMult = parte1.executarOperacao(num1, num2, &parte1.multiplicar);
    std.debug.print("Resultado da multiplicação: {}\n", .{resultadoMult});

    // Parte 2
    //AplicarOperacao utiliza polimorfismo para aceitar diferentes tipos e operações.
    const r1 = parte2.aplicarOperacao(i32, 10, 7, parte2.maximo);
    std.debug.print("Máximo: {d}\n", .{r1});

    const r2 = parte2.aplicarOperacao(i32, 10, 7, parte2.minimo);
    std.debug.print("Mínimo: {d}\n", .{r2});

    const r3 = parte2.aplicarOperacao(i32, 2, 5, parte2.potencia);
    std.debug.print("Potência: {d}\n", .{r3});

    std.debug.print("Parte 2:\n", .{});
    // Exemplos simples de Map, Filter e Reduce
    var input = [_]i32{ 1, 2, 3, 4, 5 };
    var mapped = [_]i32{0} ** 5;

    parte2.mapDouble(&input, &mapped);
    std.debug.print("Map (dobro): ", .{});
    for (mapped) |v| std.debug.print("{d} ", .{v});
    std.debug.print("\n", .{});

    var filtered = [_]i32{0} ** 5;
    const filtered_count = parte2.filterEven(&input, &filtered);
    std.debug.print("Filter (pares): ", .{});
    for (filtered[0..filtered_count]) |v| std.debug.print("{d} ", .{v});
    std.debug.print("\n", .{});

    const reduced = parte2.reduceSum(&input);
    std.debug.print("Reduce (soma): {d}\n", .{reduced});
}
