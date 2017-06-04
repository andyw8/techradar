module QuadrantList
  def self.quadrants
    [
      Quadrant.new("techniques", "nw"),
      Quadrant.new("tools", "ne"),
      Quadrant.new("platforms", "sw"),
      Quadrant.new("languages_and_frameworks", "se")
    ]
  end

  def self.names
    quadrants.map(&:name)
  end
end
