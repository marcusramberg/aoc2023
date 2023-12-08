const std = @import("std");

const MatchError = error{NoMatch};

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    const stdin_file = std.io.getStdIn().reader();
    var br = std.io.bufferedReader(stdin_file);
    const stdin = br.reader();

    var buf: [100]u8 = undefined;
    var sum: u32 = 0;
    var firstNumber: u8 = 0;
    var lastNumber: u8 = 0;
    var cipher = std.ArrayList(u8).init(allocator);
    defer cipher.deinit();
    while (try stdin.readUntilDelimiterOrEof(buf[0..], '\n')) |user_input| {
        for (user_input) |c| {
            var num: u8 = c;
            if (c < '0' or c > '9') {
                try cipher.append(c);
                // std.debug.print("Checking: {s}.\n", .{cipher.items});
                num = getNum(cipher.items) catch {
                    continue;
                };
            } 
                cipher.clearRetainingCapacity();
            }
            // std.debug.print("Found a number: {c}.\n", .{num});
            if (firstNumber == 0) {
                firstNumber = num;
            }
            lastNumber = num;
        }
        const num = (firstNumber - '0') * 10 + (lastNumber - '0');
        std.debug.print("{s} {}\n", .{ user_input, num });
        sum = sum + num;
        //std.debug.print("{}.\n", .{sum});
        firstNumber = 0;
        lastNumber = 0;
    }

    std.debug.print("{}\n", .{sum});
}

fn getNum(c: []u8) MatchError!u8 {
    const numbers = [_][]const u8{ "one", "two", "three", "four", "five", "six", "seven", "eight", "nine" };
    for (numbers, 0..) |number, i| {
        if (std.mem.endsWith(u8, c, number)) {
            return '1' + @as(u8, @intCast(i));
        }
    }
    return MatchError.NoMatch;
}
