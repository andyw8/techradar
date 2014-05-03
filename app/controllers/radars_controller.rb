class RadarsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_radar, only: [:show, :destroy]

  def index
    @radars = scoped_radars
  end

  def show
  end

  def new
    @radar = scoped_radars.new
  end

  def create
    @radar = current_user.new_radar(radar_params)
    if @radar.save
      redirect_to @radar
    else
      render 'new'
    end
  end

  def destroy
    @radar.destroy!
    redirect_to radars_path
  end

  private

  def radar_params
    params.require(:radar).permit(:name)
  end

  def scoped_radars
    current_user.radars
  end

  def find_radar
    @radar = current_user.find_radar(params[:id])
  end
end
