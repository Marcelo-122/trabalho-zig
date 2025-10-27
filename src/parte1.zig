const std = @import("std");

// --- Compartilhamento de Memória ---
// Esta variável global será compartilhada entre a thread 'main'
// e todas as threads que gerarmos.
pub var g_counter: u32 = 0;

// --- Sincronização de Threads ---
// Precisamos de um Mutex para proteger o 'g_counter'.
// Sem ele, teríamos uma "condição de corrida" (data race),
// pois várias threads tentariam ler e escrever 'g_counter' ao mesmo tempo.
pub var g_mutex = std.Thread.Mutex{};

// Esta é a função que cada thread irá executar.
pub fn thread_worker() void {
    var i: u32 = 0;
    while (i < 100_000) : (i += 1) {
        // 1. Trava o mutex. Só uma thread pode passar daqui por vez.
        g_mutex.lock();

        // 2. Seção Crítica: Acessa a memória compartilhada
        g_counter += 1;

        // 3. Libera o mutex. Outra thread agora pode entrar.
        g_mutex.unlock();
    }
}

// Função para criar e gerenciar múltiplas threads
pub fn run_threads() !void {
    const num_threads = 10;
    var threads: [num_threads]std.Thread = undefined;

    std.log.info("Thread 'main' iniciando...", .{});

    // --- Como gero threads? ---
    // Usamos 'std.Thread.spawn()' em um loop para criar 10 threads.
    // Cada thread executará a função 'thread_worker'.
    std.log.info("Gerando {} threads...", .{num_threads});
    for (&threads) |*t| {
        // '.{}' são as opções padrão
        // 'thread_worker' é a função
        // '.{}' são os argumentos (nenhum neste caso)
        t.* = try std.Thread.spawn(.{}, thread_worker, .{});
    }

    std.log.info("Aguardando todas as threads terminarem (join)...", .{});
    // 'wait()' é o 'join'. A thread 'main' pausa e espera
    // que cada thread filha termine sua execução.
    for (threads) |t| {
        t.join();
    }

    // Graças ao Mutex (sincronização), o resultado deve ser
    // exatamente 10 * 100.000 = 1.000.000.
    std.log.info("Todas as threads terminaram.", .{});
    std.log.info("Valor final do contador (deve ser 1.000.000): {}", .{g_counter});
}
