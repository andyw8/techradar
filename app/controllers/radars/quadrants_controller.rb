module Radars
  class QuadrantsController < ApplicationController
    before_action :authenticate_user!, except: :show

    def show
      @radar = Radar.find_by(uuid: params[:id])
      quadrant = QuadrantList.new.lookup(params[:quadrant])

      render "radars/show", locals: {
        radar: @radar,
        svg: RadarDiagramWithBlips.call(@radar, quadrant)
      }
    end
  end
end
