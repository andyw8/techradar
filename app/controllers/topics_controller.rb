class TopicsController < ApplicationController
  before_action :authenticate_user!

  def index
    topics_presenter = TopicsPresenter.new(scoped_topics.by_name)
    render locals: { topics: topics_presenter }
  end

  def show
    topic = scoped_topics.friendly.find(params[:id])
    render locals: { topic: topic }
  end

  def new
    topic = scoped_topics.new(params[:topic])
    render locals: { topic: topic }
  end

  def create
    topic = scoped_topics.new(topic_params)
    if topic.save
      redirect_to topics_path
    else
      render "new", locals: { topic: topic }
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:name)
  end

  def scoped_topics
    current_user.topics
  end
end
