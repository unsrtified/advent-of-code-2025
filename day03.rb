# frozen_string_literal: true

require "./utils"

banks = Utils.read_lines("inputs/day03.txt").map(&:chars)

def max_joltage(bank, n)
  bank
    .each_cons(n)
    .each_with_object(["0"] * n) { |seq, picks|
      seq.each_with_index { |battery, i|
        if battery > picks[i]
          picks[i..n] = seq[i..n]
          break
        end
      }
    }
    .join
    .to_i
end

puts "Part 1:", banks.map { |bank| max_joltage(bank, 2) }.sum
puts "Part 2:", banks.map { |bank| max_joltage(bank, 12) }.sum
