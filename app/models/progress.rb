class Progress
  def initialize(user)
    @user = user
  end

  def already_has_topics?
    user.created_topics.any?
  end

  private

  attr_reader :user
end
