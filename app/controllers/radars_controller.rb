class RadarsController < ApplicationController
  DEFAULT_QUADRANT = "tools"

  before_action :authenticate_user!, except: :show

  def index
    render "index", locals: { radars: scoped_radars }
  end

  def show
    radar = find_public_radar
    if params[:quadrant]
      corner = Blip::CORNERS.invert.fetch(params[:quadrant])
      radar_diagram = RadarDiagram.new(corner)
      radar.blips_in_quadrant(params[:quadrant].to_sym).each do |blip|
        radar_diagram.add_blip(id: "blip_#{blip.id}", ring: Blip::RINGS.index(blip.ring), title: blip.name)
      end
      @svg = radar_diagram.draw
      render "radars/show", locals: { radar: radar }
    else
      redirect_to radar_quadrant_path(radar, quadrant: DEFAULT_QUADRANT)
    end
  end

  def new
    render "new", locals: { radar: scoped_radars.new }
  end

  def edit
    radar = find_my_radar
    return redirect_to(new_user_session_path) unless radar
    render "edit", radar: radar
  end

  def update
    # :nocov:
    radar = find_my_radar
    if radar.update_attributes(radar_params)
      redirect_to radar
    else
      render "edit", radar: find_my_radar
    end
    # :nocov:
  end

  def create
    radar = current_user.new_radar(radar_params)
    if radar.save
      redirect_to radar
    else
      render "new", locals: { radar: radar }
    end
  end

  def destroy
    radar = find_my_radar
    return redirect_to(new_user_session_path) unless radar
    radar.destroy!
    redirect_to radars_path
  end

  private

  def radar_params
    params.require(:radar).permit(:name, :description, :topics)
  end

  def scoped_radars
    current_user.radars
  end

  def find_my_radar
    @radar = Radar.find_by(uuid: params[:id], owner: current_user)
  end

  def find_public_radar
    @radar = Radar.find_by(uuid: params[:id])
  end
end
