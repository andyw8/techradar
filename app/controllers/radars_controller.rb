class RadarsController < ApplicationController
  def index
    @radars = Radar.all
  end

  def new
    @radar = Radar.new
  end

  def create
    @radar = Radar.create!(radar_params)
    redirect_to action: :index
  end

  private

  def radar_params
    params.require(:radar).permit(:name)
  end
end
