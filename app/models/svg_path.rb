module SVGPath
  # Capital letters means absolutely positioned, lower cases means relatively positioned.
  COMMANDS = {
    moveto: "M",
    lineto: "L",
    horizontal_lineto: "H",
    vertical_lineto: "V",
    curveto: "C",
    smooth_curveto: "S",
    quadratic_bezier_curve: "Q",
    smooth_quadratic_bezier_curveto: "T",
    elliptical_arc: "A",
    closepath: "Z"
  }
  module Absolute
    def self.elliptical_arc(rx:, ry:, x_axis_rotation: 0, large_arc_flag: 0, sweep_flag: 0, x:, y:, opts: {})
      data = [rx, ry, x_axis_rotation, large_arc_flag, sweep_flag, x, y].join(" ")
      [COMMANDS.fetch(:elliptical_arc), data]
    end

    def self.circular_arc(r: r, x_axis_rotation: 0, large_arc_flag: 0, sweep_flag: 0, x:, y:, opts: {})
      elliptical_arc(rx: r,
                     ry: r,
                     x_axis_rotation: x_axis_rotation,
                     large_arc_flag: large_arc_flag,
                     sweep_flag: sweep_flag,
                     x: x,
                     y: y,
                     opts: opts)
    end

    def self.move_to(x:, y:)
      [COMMANDS.fetch(:moveto), x, ",", y]
    end
  end
end

