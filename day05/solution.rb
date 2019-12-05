def input
  File.open('input').read.split(',').map(&:to_i)
end

def parse_op(op)
  op = '%05d' % op
  [op[0], op[1], op[2], op[3..4]]
end

def part1(state, register)
  pos = 0
  last_output = ''

  while true
    _, mode2, mode1, op = parse_op(state[pos])
    param1 = mode1 == '1' ? (pos + 1) : state[pos + 1]
    param2 = mode2 == '1' ? (pos + 2) : state[pos + 2]

    case op
    when '01'
      output = state[pos + 3]
      state[output] = state[param1] + state[param2]
      pos += 4
    when '02'
      output = state[pos + 3]
      state[output] = state[param1] * state[param2]
      pos += 4
    when '03'
      output = state[pos + 1]
      state[output] = register
      pos += 2
    when '04'
      output = state[pos + 1]
      last_output = state[output]
      pos += 2
    when '05'
      pos = state[param1] != 0 ? state[param2] : pos + 3
    when '06'
      pos = state[param1] == 0 ? state[param2] : pos + 3
    when '07'
      output = state[pos + 3]
      state[output] = state[param1] < state[param2] ? 1 : 0
      pos += 4
    when '08'
      output = state[pos + 3]
      state[output] = state[param1] == state[param2] ? 1 : 0
      pos += 4
    when '99'
      return last_output
    end
  end
end

def part2
end

puts "Part 01: #{part1(input, 1)}"
puts "Part 02: #{part1(input, 5)}"
