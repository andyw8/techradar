class StarterTopics
  include ActiveModel::Model

  TOPICS = %i[topic_1 topic_2 topic_3]

  TOPICS.each do |topic|
    attr_accessor topic

    validates topic, presence: true
  end

  def save(user)
    topic_1_record = Topic.new(name: topic_1 + rand(9999).to_s, creator: user)
    topic_2_record = Topic.new(name: topic_2 + rand(9999).to_s, creator: user)
    topic_3_record = Topic.new(name: topic_3 + rand(9999).to_s, creator: user)
    topics = [topic_1_record, topic_2_record, topic_3_record]
    topics.map(&:save!)
    #
    # if topics.all?(&:valid?)
    # else
    # end
  end
end
