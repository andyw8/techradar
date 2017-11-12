class QuadrantList
  DEFAULTS = [
    Quadrant.new("Techniques", "techniques", "nw"),
    Quadrant.new("Tools", "tools", "ne"),
    Quadrant.new("Platforms", "platforms", "sw"),
    Quadrant.new("Languages And Frameworks", "languages_and_frameworks", "se")
  ].freeze

  def initialize(quadrants = DEFAULTS)
    @quadrants = quadrants
  end

  attr_reader :quadrants

  def values
    quadrants.map(&:value)
  end

  def lookup(value)
    quadrants.find { |quadrant| quadrant.value == value }
  end

  def names_with_values
    quadrants.each_with_object({}) do |quadrant, result|
      result[quadrant.name] = quadrant.value
    end
  end
end
