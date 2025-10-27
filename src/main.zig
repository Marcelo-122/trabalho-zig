// src/main.zig --> pra rodar só colocar zig build run
const std = @import("std");
const parte1 = @import("parte1.zig");
const parte2 = @import("parte2.zig");

pub fn main() !void {
    // Executa o exemplo de threads do módulo parte1
    std.log.info("=== Iniciando exemplo de Threads ===\n", .{});
    try parte1.run_threads();

    // Executa o exemplo de concorrência do módulo parte2
    std.log.info("\n=== Iniciando exemplo de Concorrência ===\n", .{});
    try parte2.run_concurrent_example();

    std.log.info("\n=== Todos os exemplos foram concluídos ===\n", .{});
}
