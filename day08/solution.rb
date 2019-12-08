def input
  File.read('input').chomp.chars.map(&:to_i)
end

def part1(width, height)
  layers = input.each_slice(width * height)
  layer = layers.min_by { |layer| layer.count(0) }
  layer.count(1) * layer.count(2)
end

def part2(width, height)
  layers = input.each_slice(width * height).to_a
  pixels = layers.transpose
  image = pixels.map { |pixel| pixel.select{ |p| p != 2 }.first }
  image.each_slice(width) do |line|
    puts line.map(&:to_s).join.gsub('0', ' ')
  end
end

puts "Part 01: #{part1(25, 6)}"
part2(25, 6)
