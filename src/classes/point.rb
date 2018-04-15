class Point
  def initialize(x, y)
    @x = x
    @y = y
  end

  def to_s
    "(#{x}, #{y})"
  end

  def rotate!(radians)
    cos = Math.cos(radians)
    sin = Math.sin(radians)
    xxx = x * cos
    xxx = xxx - y * sin
    yyy = y * cos
    yyy += x * sin
    @x = xxx
    @y = yyy
  end

  def scale!(n)
    @x = (x * n).to_i
    @y = (y * n).to_i
  end

  def translate!(w,h)
    @x += w
    @y += h
  end

  attr_reader :x, :y
end
