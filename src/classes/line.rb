require_relative 'point'

class Line
  def initialize(a, b)
    @a = a
    @b = b
  end

  attr_reader :a, :b

  def slope
    @slope ||= begin
      rise = b.y - a.y
      run = b.x - a.x
      rise / run
    end
  end

  def y_intercept
    @y_intercept ||= a.y - (slope * a.x)
  end

  def midpoint
    segment(2).first
  end

  def segment(n)
    [a] + Array.new(n-1).map.with_index do |_, i|
      k = ((i + 1.0) / n)
      x = a.x + (k * (b.x - a.x))
      y = a.y + (k * (b.y - a.y))
      Point.new(x, y)
    end + [b]
  end
end
