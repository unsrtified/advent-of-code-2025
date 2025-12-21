# frozen_string_literal: true

require "./utils"

machines = Utils.read_lines("inputs/day10.txt").map {
  {
    lights: /^\[(.+)\]/.match(it)[1].chars.map { (it == "#") ? 1 : 0 },
    buttons: /\] \((.+)\) \{/.match(it)[1].split(") (").map(&:to_ints),
    joltage: /\{(.+)\}$/.match(it)[1].to_ints
  }
}

def press_costs(buttons:, lights:, **)
  zeroes = Array.new(lights.size, 0)
  buttons.every_combination.each_with_object(Hash.new { _1[_2] = {} }) { |btns, costs|
    k = btns.reduce(Array.new(lights.size, 0)) { _1.update_at(*_2, &:succ) }
    parity_bits = k.map { it % 2 }
    costs[parity_bits][k] = (costs[parity_bits][k] || Float::INFINITY).min(btns.size)
  }.update(zeroes => {zeroes => 0}) { _2.merge(_3) }
end

def solver(joltage, costs, memo = {})
  return memo[joltage] if memo[joltage]
  return 0 if joltage.all?(&:zero?)

  mincost = Float::INFINITY
  costs[joltage.map { it % 2 }].each { |delta, cost|
    j = Array.new(joltage.size) { |i| joltage[i] - delta[i] }
    next if j.any? { it.odd? || it.negative? }

    mincost = mincost.min(cost + 2 * solver(j.map { it / 2 }, costs, memo))
  }
  memo[joltage] ||= mincost
end

def min_lights_cost(**m) = press_costs(**m)[m[:lights]].values.min
def min_power_cost(joltage:, **) = solver(joltage, press_costs(**))

puts "Part 1:", machines.map { min_lights_cost(**it) }.sum
puts "Part 2:", machines.map { min_power_cost(**it) }.sum
