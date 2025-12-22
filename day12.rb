# frozen_string_literal: true

require "./utils"

solution = Utils.read_lines("inputs/day12.txt")
  .drop(5 * 6)
  .map { it.split(/[x: ]+/).map(&:to_i) }
  .map { [it[0] * it[1], it[2..].map { it * 8 }.sum] }
  .filter { |a, b| a >= b }
  .size

puts "Part 1:", solution
