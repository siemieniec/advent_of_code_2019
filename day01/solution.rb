def input
  File.open('input').readlines.map(&:chomp).map(&:to_i)
end

def fuel_needed(mass)
  (mass / 3).floor - 2
end

def part1(modules)
  modules.inject(0) do |fuel, mass|
    fuel += fuel_needed(mass)
  end
end

def part2(modules)
  modules.inject(0) do |fuel, mass|
    while mass / 3 > 2
      mass = fuel_needed(mass)
      fuel += mass
    end
    fuel
  end
end

puts "Part 01: #{part1(input)}"
puts "Part 02: #{part2(input)}"
