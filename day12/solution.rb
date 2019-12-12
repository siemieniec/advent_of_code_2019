def input
  File.open('input').readlines.map(&:chomp).map do |moon|
    [moon.scan(/-?\d+/).map(&:to_i), [0, 0, 0]]
  end
end

def apply_gravity(moons)
  new_moons = []
  moons.each do |moon|
    new_moon = moon.dup
    (moons - [moon]).each do |other|
      (0..2).each do |i|
        if moon[0][i] < other[0][i]
          new_moon[1][i] += 1
        elsif moon[0][i] > other[0][i]
          new_moon[1][i] -= 1
        end
      end
    end
    new_moons += [new_moon]
  end
end

def apply_velocity(moons)
  moons.map do |pos, vel|
    [[pos[0] + vel[0], pos[1] + vel[1], pos[2] + vel[2]], vel]
  end
end

def part1
  moons = input

  1000.times do
    moons = apply_velocity(apply_gravity(moons))
  end

  moons.map do |pos, vel|
    pos.map(&:abs).sum * vel.map(&:abs).sum
  end.sum
end

def part2
end

puts "Part 01: #{part1}"
puts "Part 02: #{part2}"
