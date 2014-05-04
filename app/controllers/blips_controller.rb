class BlipsController < ApplicationController
  before_action :find_radar, only: [:new, :create, :show, :destroy]

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

  def show
    @blip = @radar.find_blip(params[:id])
  end

  def destroy
    blip = @radar.find_blip(params[:id])
    blip.destroy!
    redirect_to @radar
  end

  private

  def blip_params
    params.require(:blip).permit(:name, :quadrant, :ring, :notes)
  end

  def find_radar
    @radar = current_user.find_radar(params[:radar_id])
  end
end
