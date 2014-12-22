class TopicsPresenter
  def initialize(topics)
    @topics = topics
  end

  def each_letter
    @topics.group_by do |topic|
      topic.name[0].upcase
    end.each do |letter, topics|
      yield letter, topics
    end
  end
end
