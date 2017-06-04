module RadarDiagramWithBlips
  def self.call(radar, quadrant)
    corner = QuadrantList.new.lookup(quadrant).corner
    radar_diagram = RadarDiagram.new(corner)

    radar.blips_in_quadrant(quadrant.to_sym).each do |blip|
      radar_diagram.add_blip(id: "blip_#{blip.id}", ring: Blip::RINGS.index(blip.ring), title: blip.name)
    end

    radar_diagram.draw
  end
end
