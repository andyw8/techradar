class AddTopics
  include Service

  def initialize(topics:, creator:)
    self.topics = topics
    self.creator = creator
  end

  def call
    topics.map do |name|
      name.strip!
      next if name.blank?
      next if Topic.find_by(name: name, creator: creator)
      Topic.create!(name: name, creator: creator)
    end
  end

  private

  attr_accessor :topics, :creator
end
