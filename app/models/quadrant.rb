class Quadrant
  def initialize(name, corner)
    @name = name
    @corner = corner
  end

  attr_reader :name, :corner
end
