# frozen_string_literal: true

range_lines, ingredient_lines = File.read("inputs/day05.txt")
  .split("\n\n")
  .map { _1.split("\n") }

ranges = range_lines.map { Range.new(*_1.split("-").map(&:to_i)) }
  .sort_by { _1.begin }
  .each_with_object([]) { |r, merged|
    top = merged.pop
    if top.nil?
      merged << r
    elsif top.overlap? r
      merged << Range.new([r.begin, top.begin].min, [r.end, top.end].max)
    else
      merged << top << r
    end
  }

ingredients = ingredient_lines.map(&:to_i)

puts "Part 1:", ingredients.count { |i| ranges.any? { _1.cover? i } }
puts "Part 2:", ranges.map(&:count).sum
