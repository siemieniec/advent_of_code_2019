def input
  File.open('input').read.split('-').map(&:to_i)
end

def never_decreasing?(pass)
  pass.digits == pass.digits.sort.reverse!
end

def repeating_digit?(pass)
  pass.digits != pass.digits.uniq
end

def double_digit?(pass)
  pass.digits.chunk_while(&:==).find { |group| group.size == 2 }
end

def part1
  lower_bound, upper_bound = input
  (lower_bound..upper_bound).count do |pass|
    never_decreasing?(pass) && repeating_digit?(pass)
  end
end

def part2
  lower_bound, upper_bound = input
  (lower_bound..upper_bound).count do |pass|
    never_decreasing?(pass) && double_digit?(pass)
  end
end

puts "Part 01: #{part1}"
puts "Part 02: #{part2}"
