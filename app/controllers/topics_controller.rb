class TopicsController < ApplicationController
  before_action :authenticate_user!

  def new
    topic = scoped_topics.new(params[:topic])
    render locals: { topic: topic }
  end

  def create
    topic = scoped_topics.new(topic_params)
    if topic.save
      flash[:notice] = "Topic #{topic.name} was added"
      redirect_to radars_path
    else
      render "new", locals: { topic: topic }
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:name, :twitter_username)
  end

  def scoped_topics
    current_user.created_topics
  end
end
