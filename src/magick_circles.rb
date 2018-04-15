require_relative 'classes/render'
require_relative 'classes/star'


20.times do |picnum|
  image_size = 250
  size = (image_size * 0.94).to_i
  centerx = centery = (image_size / 2).to_i
  origin = Point.new(centerx, centery)
  shrink_factor = 0.65
  canvas = OilyPNG::Canvas.new(image_size, image_size, ChunkyPNG::Color::BLACK)
  3.times do
    case rand(10)
    when 1..7
      canvas = Render.new(size, origin, canvas ).draw
      size = (size * 0.65).to_i
    when 8..10
      canvas = Star.new(size, origin, canvas).draw
      size = (size * 0.5).to_i
    end
  end

  # canvas.save('shape.png', interlace: true, color_mode: ChunkyPNG::COLOR_TRUECOLOR)
  canvas.save("magick_#{picnum}.png")
end
