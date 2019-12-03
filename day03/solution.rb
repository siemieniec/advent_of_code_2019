def input
  File.open('input').readlines.map do |wire|
    wire.chomp.split(',')
  end
end

def trace_path(wire)
  x = 0
  y = 0
  path = []

  wire.each do |step|
    direction, steps = step[0], step[1..-1].to_i
    steps.times do
      case direction
      when 'U'
          y = y + 1
      when 'D'
          y = y - 1
      when 'L'
          x = x - 1
      when 'R'
          x = x + 1
      end
      path << [x, y]
    end
  end
  path
end

def intersections(wires)
  trace_path(wires[0]) & trace_path(wires[1])
end

def part1(wires)
  intersections(wires).map do |x, y|
    x.abs + y.abs
  end.min
end

def part2(wires)
  wire1 = trace_path(wires[0])
  wire2 = trace_path(wires[1])

  intersections(wires).map do |i|
    wire1.find_index(i) + wire2.find_index(i) + 2
  end.min
end

puts "Part 01: #{part1(input)}"
puts "Part 02: #{part2(input)}"
