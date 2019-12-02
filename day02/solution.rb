def input
  File.open('input').read.split(',').map(&:to_i).tap do |input|
    input[1] = 12
    input[2] = 2
  end
end

def part1(input)
  ops = input.each_slice(4).take_while { |op, _, _, _| op != 99 }

  ops.each do |op, in1, in2, out|
    case op
    when 1
      input[out] = input[in1] + input[in2]
    when 2
      input[out] = input[in1] * input[in2]
    end
  end

  input[0]
end

def part2(input)
  input.inspect
end

puts "Part 01: #{part1(input)}"
puts "Part 02: #{part2(input)}"
