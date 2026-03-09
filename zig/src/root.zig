const std = @import("std");

pub fn computation(a: i32, b: i32) i32 {
    return a + b;
}

test {
    std.testing.expectEqual(computation(1, 2), 3);
}
