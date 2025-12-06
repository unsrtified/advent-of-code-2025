# frozen_string_literal: true

require "./utils"

*numbers, operators = Utils.read_lines("inputs/day06.txt")

problems = operators.chars.each_index
  .filter { operators[_1] != " " }
  .append(operators.size)
  .each_cons(2)
  .map { |i, j| numbers.map { _1[i...j] } }
  .zip(operators.split(/\s+/))
  .map { |terms, op| [op.to_sym, terms] }

def solve(problems, &term_parser)
  problems.map { |op, terms| term_parser.call(terms).reduce(op) }.sum
end

puts "Part 1:", solve(problems) { _1.map(&:to_i) }

puts "Part 2:", solve(problems) { |terms|
  terms.map(&:chars).transpose.filter_map { _1.join.to_i if _1.any?(/\d/) }
}
