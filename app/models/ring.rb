class Ring
  def initialize(name, value, index)
    @name = name
    @value = value
    @index = index
  end

  attr_reader :name, :value, :index
end
