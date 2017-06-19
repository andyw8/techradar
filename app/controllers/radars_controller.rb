class RadarsController < ApplicationController
  DEFAULT_QUADRANT = "tools"

  before_action :authenticate_user!, except: :show

  def index
    render "index", locals: { radars: scoped_radars }
  end

  def show
    radar = find_public_radar
    redirect_to radar_quadrant_path(radar, quadrant: DEFAULT_QUADRANT)
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
    current_user.radars.find_by(uuid: params[:id])
  end

  def find_public_radar
    Radar.lookup(params[:id])
  end
end
