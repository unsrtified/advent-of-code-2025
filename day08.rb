# frozen_string_literal: true

require "./utils"

junctions = Utils.read_lines("inputs/day08.txt").map { _1.split(",").map(&:to_i) }

pairings = junctions.combination(2).sort_by { |a, b|
  Math.sqrt(a.zip(b).map { (_1 - _2) ** 2 }.sum)
}

connections = pairings.lazy.scan([nil, 0, {}]) { |(_, count, circuits), pair|
  a, b = pair
  case circuits.values_at(a, b)
  in nil, nil
    circuits[a] = circuits[b] = (circuits.values.max || 0) + 1
    count += 1
  in Integer => n, nil
    circuits[b] = n
  in nil, Integer => n
    circuits[a] = n
  in n, m if n != m
    circuits.transform_values! { _1 == m ? n : _1 }
    count -= 1
  else
    # n == m, do nothing
  end

  [pair, count, circuits]
}

puts "Part 1:", connections.drop(999).first[2].values.tally.values.max(3).reduce(&:*)
puts "Part 2:", connections.drop_while { |_, count, circuits|
  count != 1 || circuits.size != junctions.size
}.first[0].map(&:first).reduce(&:*)
