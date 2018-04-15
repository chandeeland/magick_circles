require_relative 'line'
class Polygon

  def initialize(num_sides)
    @num_sides = num_sides
  end

  def center
    @center ||= Point.new(0,0)
  end

  def points
    @points ||= begin
      rads = radians(angle)
      Array.new(num_sides).map.with_index do |_, i|
        Point.new( Math.cos(rads * i),  Math.sin(rads * i))
      end
    end
  end

  def perimeter
    points.map.with_index do |_, i|
      Line.new(points[i - 1], points[i])
    end.uniq
  end

  def radials
    points.map do |point|
      Line.new(center, point)
    end
  end

  def rotate!(degrees)
    rad = radians(degrees)
    points.each { |point|
      point.rotate!(rad)
    }
  end

  def scale!(n)
    points.each { |point| point.scale!(n) }
  end

  def segment!(n)
    @points = perimeter.map { |line| line.segment(n) }.flatten.uniq
    @perimeter = nil
  end

  def star(inner)
    @points = points.zip(inner.points).flatten.compact
    @perimeter = nil
  end

  def translate!(x,y)
    points.each do |point|
      point.translate!(x,y)
    end
    center.translate!(x,y)
  end

  def angle
    @angle ||= 360.0 / num_sides
  end

  attr_reader :num_sides
  private

  def radians(degrees)
    degrees * Math::PI / 180.0
  end

end
