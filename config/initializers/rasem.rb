class Rasem::SVGImage
  def path(d:, opts: {})
    @output << %{<path d="#{d}"}
    opts.each do |k, v|
      @output << %[#{k.to_s.dasherize}="#{v}"]
    end
    @output << "/>"
  end

  def circle(cx, cy, r, id, style=DefaultStyles[:circle])
    @output << %{<circle id="#{id}" cx="#{cx}" cy="#{cy}" r="#{r}"}
    write_style(style)
    @output << "/>"
  end

end
