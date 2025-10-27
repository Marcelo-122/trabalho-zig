const std = @import("std");

// Estrutura para passar dados para a thread
const DownloadTask = struct {
    url: []const u8,
    delay_ms: u64,
};

// Função que simula o download de uma URL
fn fetchUrl(task: DownloadTask) void {
    std.log.info("Iniciando download: {s}", .{task.url});

    // Simula o tempo de download
    std.Thread.sleep(task.delay_ms * std.time.ns_per_ms);

    std.log.info("Concluído: {s}", .{task.url});
}

// Função pública que executa o exemplo de concorrência
pub fn run_concurrent_example() !void {
    std.log.info("Iniciando tarefas concorrentes...", .{});

    // Cria duas tasks
    const task1 = DownloadTask{ .url = "site-lento.com", .delay_ms = 2000 };
    const task2 = DownloadTask{ .url = "site-rapido.com", .delay_ms = 1000 };

    // Cria duas threads para executar as tasks em paralelo
    const thread1 = try std.Thread.spawn(.{}, fetchUrl, .{task1});
    const thread2 = try std.Thread.spawn(.{}, fetchUrl, .{task2});

    // Aguarda ambas as threads terminarem
    thread1.join();
    thread2.join();

    std.log.info("Todas as tarefas concluídas.", .{});
}

// Exemplo de Event Loop Simples

const Task = struct {
    name: []const u8,
    delay_ms: u64,
    executed: bool = false,
};

pub fn run_event_loop_example() !void {
    std.log.info("\n--- Exemplo de Event Loop ---", .{});

    var tasks = [_]Task{
        Task{ .name = "Tarefa A", .delay_ms = 100 },
        Task{ .name = "Tarefa B", .delay_ms = 50 },
        Task{ .name = "Tarefa C", .delay_ms = 150 },
    };

    std.log.info("Event Loop iniciado. Processando {} tarefas...", .{tasks.len});

    for (&tasks) |*task| {
        std.log.info("Processando: {s} (delay: {}ms)", .{ task.name, task.delay_ms });
        std.Thread.sleep(task.delay_ms * std.time.ns_per_ms);
        task.executed = true;
        std.log.info("Concluído: {s}", .{task.name});
    }

    std.log.info("Event Loop finalizado.", .{});
}

// Operações Atômicas

pub fn run_atomic_example() !void {
    std.log.info("\n--- Operações Atômicas ---", .{});

    var counter = std.atomic.Value(u32).init(0);

    std.log.info("Valor inicial: {}", .{counter.load(.seq_cst)});

    _ = counter.fetchAdd(10, .seq_cst);
    std.log.info("Após fetchAdd(10): {}", .{counter.load(.seq_cst)});

    _ = counter.fetchSub(3, .seq_cst);
    std.log.info("Após fetchSub(3): {}", .{counter.load(.seq_cst)});

    const old = counter.swap(100, .seq_cst);
    std.log.info("Após swap(100): {} (antigo: {})", .{ counter.load(.seq_cst), old });

    std.log.info("Operações Atômicas finalizadas.", .{});
}

