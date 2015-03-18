class StarterTopicsController < ApplicationController
  def show
    @starter_topics = StarterTopics.new
  end

  def create
    # TODO: redirect if already set up starter topics
    @starter_topics = StarterTopics.new(params[:starter_topics])
    if @starter_topics.save(current_user)
      redirect_to new_radar_blip_path(current_user.radars.first), notice: "We're created a radar for you. Add your first blip to get started"
    else
      render "show"
    end
  end
end
