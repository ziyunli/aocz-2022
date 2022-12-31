const std = @import("std");
const List = std.ArrayList;
var gpa_impl = std.heap.GeneralPurposeAllocator(.{}){};
const gpa = gpa_impl.allocator();

const split = std.mem.split;

const parseInt = std.fmt.parseInt;

const print = std.debug.print;

const sort = std.sort.sort;
const asc = std.sort.asc;
const desc = std.sort.desc;


const data = @embedFile("data/day01.txt");

fn cmpByValue(context: void, a: i32, b: i32) bool {
    return std.sort.desc(i32)(context, a, b);
}

pub fn main() !void {
  // print("Day 01:{s}", .{data});
  var iter = split(u8, data, "\n");

  var buffer = List(i32).init(gpa);
  defer buffer.deinit();

  var sum: i32 = 0;

  while (iter.next()) |line| {
    if (line.len == 0) {
      buffer.append(sum) catch unreachable;
      sum = 0;
    } else {
      const num = try parseInt(i32, line, 10);
      sum += num;
    }
  }

  // Append the last elf
  buffer.append(sum) catch unreachable;

  const elves = try buffer.toOwnedSlice();

  sort(i32, elves, {}, cmpByValue);

  // Part 1
  print("Part 1: {d}\n", .{elves[0]});

  // Part 2
  print("Part 2: {d}\n", .{elves[0]+elves[1]+elves[2]});
}
