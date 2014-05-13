class TopicsPresenter
  def initialize(topics)
    @topics = topics
  end

  def by_letter
    @topics.group_by do |topic|
      topic.name[0].upcase
    end
  end
end
