class BulkTopicsController < ApplicationController
  def new
    @bulk_topic = BulkTopic.new
  end

  def create
    @bulk_topic = BulkTopic.new(bulk_topic_params)
    @bulk_topic.creator = current_user
    @bulk_topic.save
    redirect_to radars_path, notice: 'Your topics have been added.'
  end

  private

  def bulk_topic_params
    params.require(:bulk_topic).permit(:topics)
  end
end
