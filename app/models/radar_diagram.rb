class RadarPoint
  def initialize(ring:, title:, id:)
    @id = id
    @ring = ring
    @title = title
  end

  attr_reader :id, :ring, :title
end

class RadarDiagram
  UNIT = 100
  RADIUS = 10

  def initialize(corner)
    @corner = corner
    @points = []
  end

  def draw
    points.group_by(&:ring).each do |ring, points_range|
      delta = 90 / (points_range.size + 1)
      offset = delta
      points_range.each do |point|
        draw_point(units: point.ring + 0.5, theta: offset, id: point.id)
        offset += delta
      end
    end
    send("draw_#{corner}")
  end

  def draw_point(units:, theta:, id:)
    hypot = units * UNIT
    x = Math.cos(theta * Math::PI / 180) * hypot
    y = Math.sin(theta * Math::PI / 180) * hypot
    case corner
    when :nw
      x = -x
      y = -y
      x += 4 * UNIT
      y += 4 * UNIT
    when :sw
      x = -x
      x += 4 * UNIT
    when :ne
      y = -y
      y += 4 * UNIT
    end
    img.circle(x, y, RADIUS, id)
  end

  def add_blip(id:, ring:, title:)
    points << RadarPoint.new(id: id, ring: ring, title: title)
  end

  protected

  attr_reader :corner, :points

  private

  def draw_nw
    draw_arc origin_x: 4*UNIT, origin_y: 0,   radius: 4*UNIT, x: 0,   y: 4*UNIT
    draw_arc origin_x: 4*UNIT, origin_y: 1*UNIT, radius: 3*UNIT, x: 1*UNIT, y: 4*UNIT
    draw_arc origin_x: 4*UNIT, origin_y: 2*UNIT, radius: 2*UNIT, x: 2*UNIT, y: 4*UNIT
    draw_arc origin_x: 4*UNIT, origin_y: 3*UNIT, radius: 1*UNIT, x: 3*UNIT, y: 4*UNIT
  end

  def draw_ne
    draw_arc origin_x: 4*UNIT, origin_y: 4*UNIT, radius: 4*UNIT, x: 0, y: 0
    draw_arc origin_x: 3*UNIT, origin_y: 4*UNIT, radius: 3*UNIT, x: 0, y: 1*UNIT
    draw_arc origin_x: 2*UNIT, origin_y: 4*UNIT, radius: 2*UNIT, x: 0, y: 2*UNIT
    draw_arc origin_x: 1*UNIT, origin_y: 4*UNIT, radius: 1*UNIT, x: 0, y: 3*UNIT
  end
  
  def draw_sw
    draw_arc origin_x: 0,      origin_y: 0, radius: 4*UNIT, x: 4*UNIT, y: 4*UNIT
    draw_arc origin_x: 1*UNIT, origin_y: 0, radius: 3*UNIT, x: 4*UNIT, y: 3*UNIT
    draw_arc origin_x: 2*UNIT, origin_y: 0, radius: 2*UNIT, x: 4*UNIT, y: 2*UNIT
    draw_arc origin_x: 3*UNIT, origin_y: 0, radius: 1*UNIT, x: 4*UNIT, y: 1*UNIT
  end
  
  def draw_se
    draw_arc origin_x: 0, origin_y: 4*UNIT, radius: 4*UNIT, x: 4*UNIT, y: 0
    draw_arc origin_x: 0, origin_y: 3*UNIT, radius: 3*UNIT, x: 3*UNIT, y: 0
    draw_arc origin_x: 0, origin_y: 2*UNIT, radius: 2*UNIT, x: 2*UNIT, y: 0
    draw_arc origin_x: 0, origin_y: 1*UNIT, radius: 1*UNIT, x: 1*UNIT, y: 0
  end

  
  def draw_arc(origin_x:, origin_y:, radius:, x:, y:)
    opts = { fill: "none", stroke: "black", stroke_width: 2 }
    data = [
      SVGPath::Absolute.move_to(x: origin_x, y: origin_y),
      SVGPath::Absolute.circular_arc(r: radius, x: x, y: y, opts: opts),
    ].join(" ")
    img.path(d: data, opts: opts)
  end

  def img
    @img ||= Rasem::SVGImage.new(UNIT*4, UNIT*4)
  end
end
