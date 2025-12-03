# frozen_string_literal: true

require "./utils"

ranges = Utils.read_lines("inputs/day02.txt")
  .first
  .strip
  .split(",")
  .map { |range| Range.new(*range.split("-")) }

def extract_ids(ranges, pattern)
  ranges.flat_map { |range|
    range.filter { |s| s.match? pattern }
  }
end

puts "Part 1:", extract_ids(ranges, /^(\d+)\1$/).map(&:to_i).sum
puts "Part 2:", extract_ids(ranges, /^(\d+)\1+$/).map(&:to_i).sum
