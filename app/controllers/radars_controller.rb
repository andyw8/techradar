class RadarsController < ApplicationController
  before_action :authenticate_user!

  def index
    @radars = scoped_radars
  end

  def new
    @radar = Radar.new
  end

  def create
    @radar = scoped_radars.create!(radar_params)
    redirect_to action: :index
  end

  private

  def radar_params
    params.require(:radar).permit(:name)
  end

  def scoped_radars
    current_user.radars
  end
end
