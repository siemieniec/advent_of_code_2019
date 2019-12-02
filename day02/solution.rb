def input(noun, verb)
  File.open('input').read.split(',').map(&:to_i).tap do |input|
    input[1] = noun
    input[2] = verb
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

def part2
  (0..99).each do |noun|
    (0..99).each do |verb|
      return 100 * noun + verb if part1(input(noun, verb)) == 19690720
    end
  end
end

puts "Part 01: #{part1(input(12, 2))}"
puts "Part 02: #{part2}"
