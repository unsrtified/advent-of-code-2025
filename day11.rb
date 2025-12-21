# frozen_string_literal: true

require "./utils"

REACTOR = Utils.read_lines("inputs/day11.txt")
  .map { it.split(/[: ]+/) }
  .map { |device, *outputs| [device, outputs] }
  .to_h
REACTOR.default = []

def dfs(v, goal, memo = {})
  return 1 if v == goal
  return memo[v] if memo[v]
  memo[v] = REACTOR[v].map { dfs(it, goal, memo) }.sum
end

def paths(*vertices) = vertices.each_cons(2).map { dfs(*it) }.reduce(:*)

puts "Part 1:", paths("you", "out")
puts "Part 2:", paths("svr", "fft", "dac", "out") + paths("svr", "dac", "fft", "out")
