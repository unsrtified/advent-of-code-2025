# frozen_string_literal: true

require "./utils"

INPUT_FILE = "inputs/day01.txt"
SAFE_STARTING_POINT = 50

moves = Utils.read_lines(INPUT_FILE).map { |line|
  {op: (line[0] == "L") ? :- : :+, val: Integer(line[1..])}
}

puts "Part 1:", moves.reduce([SAFE_STARTING_POINT]) { |positions, move|
  n = positions.last.public_send(move[:op], move[:val])
  n %= 100
  positions << n
}.count(0)

puts "Part 2:", moves.reduce([SAFE_STARTING_POINT, 0]) { |state, move|
  start_pos, zeroes = state
  q, r = start_pos.public_send(move[:op], move[:val]).divmod(100)
  zeroes += q.abs
  if move[:op] == :-
    zeroes -= 1 if start_pos == 0
    zeroes += 1 if r == 0
  end
  [r, zeroes]
}.last
