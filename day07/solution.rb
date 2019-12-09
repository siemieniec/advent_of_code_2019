class Amplifier
  def initialize(registers)
    @instructions = instructions
    @position = 0
    @registers = registers
  end

  def process
    step while @state != :finished
    @registers.last
  end

  private

  def step
    _, mode2, mode1, op = parse_op(@instructions[@position])
    param1 = mode1 == '1' ? (@position + 1) : @instructions[@position + 1]
    param2 = mode2 == '1' ? (@position + 2) : @instructions[@position + 2]

    case op
    when '01'
      output = @instructions[@position + 3]
      @instructions[output] = @instructions[param1] + @instructions[param2]
      @position += 4
    when '02'
      output = @instructions[@position + 3]
      @instructions[output] = @instructions[param1] * @instructions[param2]
      @position += 4
    when '03'
      output = @instructions[@position + 1]
      if @registers.empty?
        @state = :waiting
      else
        @instructions[output] = @registers.shift
        @position += 2
      end
    when '04'
      output = @instructions[@position + 1]
      @registers.push @instructions[output]
      @position += 2
    when '05'
      @position = @instructions[param1] != 0 ? @instructions[param2] : @position + 3
    when '06'
      @position = @instructions[param1] == 0 ? @instructions[param2] : @position + 3
    when '07'
      output = @instructions[@position + 3]
      @instructions[output] = @instructions[param1] < @instructions[param2] ? 1 : 0
      @position += 4
    when '08'
      output = @instructions[@position + 3]
      @instructions[output] = @instructions[param1] == @instructions[param2] ? 1 : 0
      @position += 4
    when '99'
      @state = :finished
    end
  end

  def parse_op(op)
    op = '%05d' % op
    [op[0], op[1], op[2], op[3..4]]
  end

  def instructions
    File.open('input').read.split(',').map(&:to_i)
  end
end

def part1
  [0, 1, 2, 3, 4].permutation.map do |phase|
    amp_a = Amplifier.new([phase[0], 0])
    amp_b = Amplifier.new([phase[1], amp_a.process])
    amp_c = Amplifier.new([phase[2], amp_b.process])
    amp_d = Amplifier.new([phase[3], amp_c.process])
    Amplifier.new([phase[4], amp_d.process]).process
  end.max
end

def part2
  [5, 6, 7, 8, 9].permutation.map do |phase|
    amp_a = Amplifier.new([phase[0], 0])
    amp_b = Amplifier.new([phase[1], amp_a.process])
    amp_c = Amplifier.new([phase[2], amp_b.process])
    amp_d = Amplifier.new([phase[3], amp_c.process])
    amp_e = Amplifier.new([phase[4], amp_d.process])

    return result_e if amp_e.finished?
  end
end

puts "Part 01: #{part1}"
#puts "Part 02: #{part2}"

