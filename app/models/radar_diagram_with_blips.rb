module RadarDiagramWithBlips
  def self.call(radar, quadrant)
    radar_diagram = RadarDiagram.new(quadrant.corner)

    radar.blips_in_quadrant(quadrant).each do |blip|
      radar_diagram.add_blip(
        id: "blip_#{blip.id}",
        ring: blip.ring_object,
        title: blip.name
      )
    end

    radar_diagram.draw
  end
end
