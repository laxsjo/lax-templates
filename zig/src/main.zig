const std = @import("std");
const root = @import("root.zig");

pub fn main() !void {
    std.debug.print("Hi, {d}!\n", .{root.computation(2, 3)});
}
