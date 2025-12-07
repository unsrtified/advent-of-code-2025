# frozen_string_literal: true

require "./utils"

manifold = Utils.read_lines("inputs/day07.txt")

splits, beams = manifold[1..]
  .reduce([0, {manifold[0].index("S") => 1}]) { |(splits, beams), line|
    bs = beams.each_with_object({}) { |(i, timelines), nbeams|
      if line[i] == "^"
        nbeams[i - 1] = nbeams.fetch(i - 1, 0) + timelines
        nbeams[i + 1] = nbeams.fetch(i + 1, 0) + timelines
        splits += 1
      else
        nbeams[i] = nbeams.fetch(i, 0) + timelines
      end
    }
    [splits, bs]
  }

puts "Part 1:", splits
puts "Part 2:", beams.values.sum
