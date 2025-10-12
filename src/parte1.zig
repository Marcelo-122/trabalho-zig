const std = @import("std");

pub fn somar(a: i32, b: i32) i32 {
    return a + b;
}

pub fn multiplicar(a: i32, b: i32) i32 {
    return a * b;
}

pub fn executarOperacao(a: i32, b: i32, operacao: *const fn (i32, i32) i32) i32 {
    std.debug.print("Executando a operação...\n", .{});
    const resultado = operacao(a, b);
    return resultado;
}
