# frozen_string_literal: true

require "./utils"

DIRECTIONS = [0, 1, -1].product([0, 1, -1]).drop(1).freeze

grid = Utils.read_lines("inputs/day04.txt")
  .map { |s|
    s.chars.each_with_index.filter { |ch, _| ch == "@" }
  }
  .each_with_index
  .each_with_object({}) { |(cols, row), grid|
    cols.each { |x, col| grid[[row, col]] = x }
  }

def removable_rolls(grid)
  grid.filter { |pos|
    DIRECTIONS
      .map { |d| [pos[0] + d[0], pos[1] + d[1]] }
      .count { grid[_1] } < 4
  }
end

puts "Part 1:", removable_rolls(grid).size

puts "Part 2:", [grid].cycle.lazy.map { |g|
  removable_rolls(g).tap { |rolls|
    rolls.each_key { g.delete(_1) }
  }.size
}.take_while { _1 > 0 }.sum
