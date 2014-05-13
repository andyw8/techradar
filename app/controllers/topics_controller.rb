class TopicsController < ApplicationController
  def index
    topics_presenter = TopicsPresenter.new(Topic.order("lower(name)"))
    render locals: { topics: topics_presenter }
  end

  def show
    topic = Topic.friendly.find(params[:id])
    render locals: { topic: topic }
  end
end
