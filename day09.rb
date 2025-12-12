# frozen_string_literal: true

require "./utils"

tiles = Utils.read_lines("inputs/day09.txt")
  .map { it.split(",").map(&:to_i) }

rectangles = tiles.combination(2)
  .map { |(x, y), (a, b)|
    [((x - a).abs + 1) * ((y - b).abs + 1), [x, y], [a, b]]
  }
  .sort_by { |a| -a[0] }

puts "Part 1:", rectangles[0][0]

NEIGHBOURS = [0, -1, 1].product([0, -1, 1]).drop(1).freeze

def neighbours(p) = NEIGHBOURS.map { |dx, dy| [p[0] + dx, p[1] + dy] }

perimeter = (tiles + [tiles[0]]).each_cons(2).each_with_object({}) { |(a, b), p|
  if a[1] == b[1]
    Range.new(*[a[0], b[0]].sort).each { p[[it, a[1]]] = true }
  else
    Range.new(*[a[1], b[1]].sort).each { p[[a[0], it]] = true }
  end
}

x, y = perimeter.keys.min_by(&:first)
work, visited, outline = [[x - 1, y]], {}, Hash.new { _1[_2] = {} }
while (point = work.pop)
  next if visited[point]
  visited[point] = true
  next unless neighbours(point).any? { perimeter[it] }
  outline[point[0]][point[1]] = true
  work.append(*neighbours(point).reject { perimeter[it] })
end

puts "Part 2:", rectangles.rotate(rectangles.size / 2.5).each { |area, a, b|
  x1, x2 = [a[0], b[0]].minmax
  y1, y2 = [a[1], b[1]].minmax
  next area if (x1..x2).any? { outline[it][y1] || outline[it][y2] }
  next area if (y1..y2).any? { outline[x1][it] || outline[x2][it] }
  break area
}
