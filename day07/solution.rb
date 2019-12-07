class Amplifier
  attr_reader :last_output

  def initialize
    @instructions = instructions
    @position = 0
    @last_output = nil
    @state = :processing
  end

  def process(register)
    while true
      puts @state
      case @state
      when :wait
        return @last_output
      when :finished
        return @last_output
      else
        step(register)
      end
    end
  end

  def step(register)
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
      @instructions[output] = register
      @position += 2
    when '04'
      output = @instructions[@position + 1]
      @last_output = @instructions[output]
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

  private

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
    amp_a = Amplifier.new
    amp_b = Amplifier.new
    amp_c = Amplifier.new
    amp_d = Amplifier.new
    amp_e = Amplifier.new
    result = amp_a.process(0)
    result = amp_a.process(phase[0])
    result = amp_b.process(result)
    result = amp_b.process(phase[1])
    result = amp_c.process(result)
    result = amp_c.process(phase[2])
    result = amp_d.process(result)
    result = amp_d.process(phase[3])
    result = amp_e.process(result)
    result = amp_e.process(phase[4])
    amp_e.last_output
  end.max_by { |result| result[0] }
end

def part2
  [5, 6, 7, 8, 9].permutation.map do |phase|
    puts phase.inspect
    amp = 0
    results = []
    phase.cycle do |p|
      puts [amp, p].inspect
      amp = intcode_comp(input, [amp, p])
      break if results.include? amp
      results << amp if p == phase[4]
    end
    results.max
  end
end

puts "Part 01: #{part1}"
#puts "Part 02: #{part2}"
