// src/main.zig --> pra rodar só colocar zig build run
const std = @import("std");

pub fn main() !void {
    try std.fs.File.stdout().writeAll("Hello, World!\n");
}
