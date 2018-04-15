require 'oily_png'
require 'pry'
require_relative 'polygon'

class Render
  def initialize(size, origin, canvas = nil )
    @size = size
    @canvas = canvas
    @origin = origin
  end

  attr_reader :size, :shape, :origin

  def canvas
    @canvas ||= OilyPNG::Canvas.new(size, ChunkyPNG::Color::BLACK)
  end

  def draw
    shape = Polygon.new([3,4,5,6,7,8,12].sample)

    shape.rotate!(rand(0..360))
    shape.segment!(rand(2..3)) if shape.num_sides < 6
    shape.scale!(size * scale_factor)
    shape.translate!(origin.x, origin.y)

    puts "#{size}, #{origin.x} "

    draw_circle
    draw_perimeter(shape) if rand(10) <= 8
    draw_radials(shape) if rand(10) <= 7
    draw_points(shape, point_size(12)) if rand(10) < 6
    draw_points(shape, point_size(10)) if rand(10) < 6
    draw_points(shape, point_size(6)) if rand(10) < 6

    canvas
  end

  def point_size(n)
    [(n / 450.0 * size).to_i, 2].max
  end

  def draw_circle
    case rand(5)
    when 1..2
      canvas.circle(origin.x, origin.y , (size/2)- 1, ChunkyPNG::Color::WHITE, ChunkyPNG::Color::BLACK)
    when 3
      canvas.circle(origin.x, origin.y , (size/2)- 1, ChunkyPNG::Color::WHITE, ChunkyPNG::Color::BLACK)
    when 4
      canvas.circle(origin.x, origin.y , (size/2)- 1, ChunkyPNG::Color::WHITE)
    end
  end

  def draw_perimeter(shape)
    color = ChunkyPNG::Color::WHITE
    # color = ChunkyPNG::Color::PREDEFINED_COLORS.values.sample
    shape.perimeter.each do |line|
      canvas.line(line.a.x, line.a.y, line.b.x, line.b.y, color)
    end
  end

  def draw_radials(shape)
    shape.radials.each do |line|
      canvas.line(line.a.x, line.a.y, line.b.x, line.b.y, ChunkyPNG::Color::WHITE)
    end
  end

  def draw_points(shape, radius)
    point_radius = radius * point_scale
    shape.points.each do |p|
      canvas.circle(p.x, p.y, point_radius, ChunkyPNG::Color::WHITE, ChunkyPNG::Color::BLACK)
    end
  end


  def point_scale
    (1.0 * size / origin.x).to_i + 1
  end

  def scale_factor
    @scale_factor ||= 0.5
  end

end
