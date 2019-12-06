def orbits
  @orbits ||= File.open('input')
    .readlines
    .map(&:chomp)
    .map { |orb| orb.split(')') }
end

def system_map
  @system_map ||= orbits
    .group_by { |orbit| orbit[0] }
    .map { |k, v| [k, v.map { |v| v[1] }] }
end

def uniq_objects
  @uniq_objects ||= system_map.flatten.uniq - ['COM']
end

def find_parent(obj)
  system_map.find { |o| o[1].include? obj}[0]
end

def parents(obj)
  parents = []
  parents << find_parent(obj)

  while parents[-1] != 'COM'
    parents << find_parent(parents[-1])
  end

  parents
end

def part1
  uniq_objects.map { |obj| parents(obj).count }.sum
end

def part2
  you_parents = parents('YOU')
  san_parents = parents('SAN')
  common_orbit = (you_parents & san_parents)[0]

  you_parents.find_index(common_orbit) + san_parents.find_index(common_orbit)
end

puts "Part 01: #{part1}"
puts "Part 02: #{part2}"
