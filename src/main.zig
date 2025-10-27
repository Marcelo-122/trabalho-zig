// src/main.zig --> pra rodar só colocar zig build run
const std = @import("std");
const parte1 = @import("parte1.zig");
const parte2 = @import("parte2.zig");

pub fn main() !void {

    std.log.info("PARTE 1 - THREADS", .{});
    try parte1.run_threads();

    std.log.info("PARTE 2 - MODELOS DE CONCORRÊNCIA", .{});

    // 1. Concorrência com Threads
    std.log.info("\n--- 1. Concorrência com Threads ---", .{});
    try parte2.run_concurrent_example();

    // 2. Event Loop
    std.log.info("\n--- 2. Event Loop ---", .{});
    try parte2.run_event_loop_example();

    // 3. Operações Atômicas
    std.log.info("\n--- 3. Operações Atômicas ---", .{});
    try parte2.run_atomic_example();

    std.log.info("TODOS OS EXEMPLOS CONCLUÍDOS", .{});
}

