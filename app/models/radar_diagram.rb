class RadarDiagram
  # :nocov:
  DEGREES_IN_QUADRANT = 90
  UNIT = 100
  RADIUS = 10

  def initialize(corner)
    @corner = corner
    @points = []
  end

  def draw
    points.group_by(&:ring).each do |_ring, points_range|
      delta = DEGREES_IN_QUADRANT / (points_range.size + 1)
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

  private

  attr_reader :corner, :points

  def draw_nw
    draw_arc origin_x: 4 * UNIT, origin_y: 0, radius: 4 * UNIT, x: 0, y: 4 * UNIT
    draw_arc origin_x: 4 * UNIT, origin_y: 1 * UNIT, radius: 3 * UNIT, x: 1 * UNIT, y: 4 * UNIT
    draw_arc origin_x: 4 * UNIT, origin_y: 2 * UNIT, radius: 2 * UNIT, x: 2 * UNIT, y: 4 * UNIT
    draw_arc origin_x: 4 * UNIT, origin_y: 3 * UNIT, radius: 1 * UNIT, x: 3 * UNIT, y: 4 * UNIT
    draw_labels(:nw)
  end

  def draw_ne
    draw_arc origin_x: 4 * UNIT, origin_y: 4 * UNIT, radius: 4 * UNIT, x: 0, y: 0
    draw_arc origin_x: 3 * UNIT, origin_y: 4 * UNIT, radius: 3 * UNIT, x: 0, y: 1 * UNIT
    draw_arc origin_x: 2 * UNIT, origin_y: 4 * UNIT, radius: 2 * UNIT, x: 0, y: 2 * UNIT
    draw_arc origin_x: 1 * UNIT, origin_y: 4 * UNIT, radius: 1 * UNIT, x: 0, y: 3 * UNIT
    draw_labels(:ne)
  end

  def draw_sw
    draw_arc origin_x: 0, origin_y: 0, radius: 4 * UNIT, x: 4 * UNIT, y: 4 * UNIT
    draw_arc origin_x: 1 * UNIT, origin_y: 0, radius: 3 * UNIT, x: 4 * UNIT, y: 3 * UNIT
    draw_arc origin_x: 2 * UNIT, origin_y: 0, radius: 2 * UNIT, x: 4 * UNIT, y: 2 * UNIT
    draw_arc origin_x: 3 * UNIT, origin_y: 0, radius: 1 * UNIT, x: 4 * UNIT, y: 1 * UNIT
    draw_labels(:sw)
  end

  def draw_se
    draw_arc origin_x: 0, origin_y: 4 * UNIT, radius: 4 * UNIT, x: 4 * UNIT, y: 0
    draw_arc origin_x: 0, origin_y: 3 * UNIT, radius: 3 * UNIT, x: 3 * UNIT, y: 0
    draw_arc origin_x: 0, origin_y: 2 * UNIT, radius: 2 * UNIT, x: 2 * UNIT, y: 0
    draw_arc origin_x: 0, origin_y: 1 * UNIT, radius: 1 * UNIT, x: 1 * UNIT, y: 0
    draw_labels(:se)
  end

  def draw_arc(origin_x:, origin_y:, radius:, x:, y:)
    opts = { fill: "none", stroke: "black", stroke_width: 2 }
    data = [
      SVGPath::Absolute.move_to(x: origin_x, y: origin_y),
      SVGPath::Absolute.circular_arc(r: radius, x: x, y: y, opts: opts)
    ].join(" ")
    img.path(d: data, opts: opts)
  end

  def img
    @img ||= Rasem::SVGImage.new(UNIT * 4, UNIT * 4)
  end

  def draw_labels(corner)
    rings = %w[Adopt Trial Assess Hold]
    if corner.in?(%i[ne nw])
      rings.reverse! if corner == :nw
      rings.each_with_index do |name, index|
        img.text(20 + index * UNIT, 4 * UNIT - 5, name)
      end
    end
    if corner.in?(%i[se sw])
      # rings.reverse! if corner == :nw
      rings.each_with_index do |name, index|
        left_margin = 10
        left_margin = 3.25 * UNIT if corner == :sw
        img.text(left_margin, UNIT * 0.5 + index * UNIT, name)
      end
    end
    img.text(0, 0, "")
  end
  # :nocov:
end
