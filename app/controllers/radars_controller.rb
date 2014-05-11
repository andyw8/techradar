class RadarsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :find_radar, only: [:show, :destroy]

  def index
    @radars = scoped_radars
  end

  def show
    @radar = @radar.decorate
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
    radar_id = params.fetch(:id)
    if current_user
      @radar = current_user.find_radar(radar_id)
    else
      @radar = Radar.find(radar_id)
    end
  end
end
