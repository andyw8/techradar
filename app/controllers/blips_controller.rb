class BlipsController < ApplicationController
  before_filter :find_radar

  def new
    @blip = @radar.blips.new
  end

  def create
    @blip = @radar.blips.create!(blip_params)
    redirect_to @radar
  end

  private

  def blip_params
    params.require(:blip).permit(:name)
  end

  def find_radar
    @radar = current_user.find_radar(params[:radar_id])
  end
end
