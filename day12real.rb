# frozen_string_literal: true

require "./utils"

*gifts, trees = Utils.read_lines("inputs/day12.txt").slice_after(&:empty?).to_a

AREAS = gifts.map { [it[0].to_i, it[1...-1].join.count("#")] }.to_h
TREES = trees.map { it.split(/[x: ]+/).map(&:to_i) }
  .map {
    [
      it[0] * it[1],
      it[2..].each_with_index.map { _1 * AREAS[_2] }.sum
    ]
  }

puts "Part 1:", TREES.count { |a, b| a >= b }
