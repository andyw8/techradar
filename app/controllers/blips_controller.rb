class BlipsController < ApplicationController
  before_action :find_radar, only: [:new, :create]

  def new
    @blip = @radar.new_blip({})
  end

  def create
    @blip = @radar.new_blip(blip_params)
    if @blip.save
      redirect_to @radar
    else
      render 'new'
    end
  end

  private

  def blip_params
    params.require(:blip).permit(:name, :quadrant, :ring)
  end

  def find_radar
    @radar = current_user.find_radar(params[:radar_id])
  end
end
