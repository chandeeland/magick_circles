require_relative 'render'

class Star < Render

  def draw
    outer.translate!(origin.x, origin.y)
    draw_points(outer, 6) if rand(10) > 4
    draw_perimeter(outer) if rand(10) > 8

    inner.translate!(origin.x, origin.y)
    draw_perimeter(inner) if rand(10) > 8

    outer.star(inner)
    draw_perimeter(outer)
    draw_points(outer, point_size(5)) if rand(10) > 5
    draw_points(inner, point_size(4)) if rand(10) > 6
    draw_points(inner, point_size(2)) if rand(10) > 6

    canvas
  end


  def outer
    @outer ||= Polygon.new([4,5,6,7,8,12].sample).tap do |o|
      # o.rotate!(rand(o.angle))
      o.scale!(size * scale_factor)
    end
  end

  def inner
    @inner ||= Polygon.new(outer.num_sides).tap do |i|
      i.rotate!(outer.angle / 2.0)
      i.scale!(size * spikiness)
    end
  end

  def spikiness
    rand(25..40) / 100.0
  end

  def scale_factor
    @scale_factor ||= 0.5
  end

end
