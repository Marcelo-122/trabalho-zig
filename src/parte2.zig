const std = @import("std");

// Função genérica para pegar o máximo
pub fn maximo(a: anytype, b: anytype) @TypeOf(a) {
    return if (a > b) a else b;
}

// Função genérica para pegar o mínimo
pub fn minimo(a: anytype, b: anytype) @TypeOf(a) {
    return if (a < b) a else b;
}

// Função de potência (somente inteiros)
pub fn potencia(a: anytype, b: anytype) @TypeOf(a) {
    var resultado = a;
    if (b == 0) return 1;
    var i: usize = 1;
    while (i < b) : (i += 1) {
        resultado *= a;
    }
    return resultado;
}

// Função de alta ordem genérica
pub fn aplicarOperacao(comptime T: type, a: T, b: T, operacao: anytype) T {
    std.debug.print("Executando operação...\n", .{});
    return operacao(a, b);
}

// Map: dobra os valores
pub fn mapDouble(input: []const i32, output: []i32) void {
    for (input, 0..) |item, i| {
        output[i] = item * 2;
    }
}

// Filter: mantem apenas os pares
pub fn filterEven(input: []const i32, output: []i32) usize {
    var count: usize = 0;
    for (input) |item| {
        if (@rem(item, 2) == 0) {
            output[count] = item;
            count += 1;
        }
    }
    return count;
}

// Reduce: soma todos os valores
pub fn reduceSum(input: []const i32) i32 {
    var sum: i32 = 0;
    for (input) |item| {
        sum += item;
    }
    return sum;
}
