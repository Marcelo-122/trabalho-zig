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
