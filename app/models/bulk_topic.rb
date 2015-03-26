class BulkTopic
  include ActiveModel::Model

  attr_accessor :topics, :creator

  def save
    topic_list = topics.split("\n")
    AddTopics.call(topics: topic_list, creator: creator)
  end
end
