module Topics
  class Blippable
    include Service

    def initialize(radar)
      @radar = radar
    end

    def call
      user = radar.owner
      Topic.where(creator_id: user).reject do |topic|
        radar.topic?(topic)
      end
    end

    private

    attr_reader :radar
  end
end
