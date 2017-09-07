class Quadrant
  def self.default
    "tools"
  end

  def initialize(name, value, corner)
    @name = name
    @value = value
    @corner = corner
  end

  attr_reader :name, :value, :corner
end
