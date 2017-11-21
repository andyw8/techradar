module Users
  class TopicsController < ApplicationController
    def index
      @topics = current_user.topics.by_name
    end
  end
end
