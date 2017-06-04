class RingList
  include Enumerable

  DEFAULTS = [
    Ring.new("Adopt", "adopt", 0),
    Ring.new("Trial", "trial", 1),
    Ring.new("Assess", "assess", 2),
    Ring.new("Hold", "hold", 3)
  ]

  def initialize(rings = DEFAULTS)
    @rings = rings
  end

  def each
    @rings.each { |ring| yield(ring) }
  end

  def values
    map(&:value)
  end

  def names_with_values
    each_with_object({}) do |ring, result|
      result[ring.name] = ring.value
    end
  end
end
