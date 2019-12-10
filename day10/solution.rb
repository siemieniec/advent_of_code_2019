def input
  File.open('input').readlines.map(&:chomp).map(&:chars)
end

def asteroids
  input.map.with_index do |belt, y|
    belt.map.with_index do |space, x|
      space == '#' ? [x, y] : nil
    end
  end.flatten(1).compact
end

def angle(point)
  Math.atan2(point[1], point[0])
end

def visibility(asteroids, asteroid)
  (asteroids - [asteroid]).map do |other|
    angle [other[0] - asteroid[0], other[1] - asteroid[1]]
  end.uniq.length
end

def destructibility(asteroids, laser)
  sorted = (asteroids - [laser]).map do |other|
    [angle([other[0] - laser[0], other[1] - laser[1]]), (other[0] - laser[0]).abs + (other[1] - laser[1]).abs, other]
  end.group_by { |other| other[0] }.sort_by { |key, val| key }

  to_rotate = sorted.select { |k, v| k < Math::PI / -2 }.length
  sorted.rotate(to_rotate).map do |key, val|
    val.sort_by { |v| v[1] }.map { |v| v[2] }
  end
end

def part1
  asteroids.map do |asteroid|
    [asteroid, visibility(asteroids, asteroid)]
  end.max_by { |ast| ast[1] }
end

def part2(laser)
  ordered = destructibility(asteroids, laser)
  largest = ordered.map { |line| line.length }.max
  nth = ordered.map do |line|
    line += Array.new(largest - line.length, nil)
  end.transpose.flatten(1).at(199)
  nth[0] * 100 + nth[1]
end

puts "Part 01: #{part1[1]}"
puts "Part 02: #{part2 part1[0]}"
