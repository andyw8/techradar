class RadarsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :find_radar, only: [:destroy, :edit, :update]
  before_action :find_public_radar, only: :show

  def index
    @radars = scoped_radars
  end

  def show
    @radar = @radar.decorate
    if params[:quadrant]
      corner = Blip::CORNERS.invert.fetch(params[:quadrant])
      radar_diagram = RadarDiagram.new(corner)
      @radar.blips_in_quadrant(params[:quadrant].to_sym).each do |blip|
        radar_diagram.add_blip(id: "blip_#{blip.id}", ring: Blip::RINGS.index(blip.ring), title: blip.name)
      end
      @svg = radar_diagram.draw
    end
  end

  def new
    @radar = scoped_radars.new
  end

  def edit
  end

  def update
    if @radar.update_attributes(radar_params)
      redirect_to @radar
    else
      render "edit"
    end
  end

  def create
    @radar = current_user.new_radar(radar_params)
    if @radar.save
      redirect_to @radar
    else
      render "new"
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
    radar_uuid = params.fetch(:id)
    @radar = current_user.find_radar(uuid: radar_uuid)
  end

  def find_public_radar
    @radar = Radar.find_by!(uuid: params[:id])
  end
end
