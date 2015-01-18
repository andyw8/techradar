class Rasem::SVGImage
  def path(d:, opts: {})
    @output << %Q{<path d="#{d}"}
    opts.each do |k, v|
      @output << %Q[#{k.to_s.dasherize}="#{v}"]
    end
    @output << %Q{/>}
  end

  def circle(cx, cy, r, id, style=DefaultStyles[:circle])
    @output << %Q{<circle id="#{id}" cx="#{cx}" cy="#{cy}" r="#{r}"}
    write_style(style)
    @output << %Q{/>}
  end

end
