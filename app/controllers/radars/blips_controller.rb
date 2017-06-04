module Radars
  class BlipsController < ApplicationController
    before_action :authenticate_user!, except: :show

    def new
      @blip = radar.new_blip(params[:blip])
      render "new", locals: { quadrants: quadrants, rings: rings, blip: blip, topics: topics }
    end

    def create
      @blip = radar.new_blip(blip_params)
      if @blip.save
        redirect_to radar_quadrant_path(radar, quadrant: blip.quadrant)
      else
        render "new", locals: { quadrants: quadrants, rings: rings, blip: blip, topics: topics }
      end
    end

    def show
      render "show", locals: { quadrants: quadrants, rings: rings, blip: blip } # , topics: topics }
    end

    def edit
      render "edit", locals: { quadrants: quadrants, rings: rings, blip: blip, topics: topics }
    end

    def update
      if blip.update(blip_params)
        redirect_to radar, notice: "Blip updated"
      else
        render "edit", locals: { quadrants: quadrants, rings: rings, blip: blip, topics: topics }
      end
    end

    def destroy
      blip.destroy!
      quadrant = blip.quadrant
      redirect_to radar_quadrant_path(radar, quadrant)
    end

    private

    def blip_params
      params.require(:blip).permit(:topic_id, :quadrant, :ring, :notes)
    end

    def radar
      @radar ||= if current_user
                   current_user.find_radar(uuid: params[:radar_id])
                 else
                   Radar.lookup(params[:radar_id])
                 end
    end

    def blip
      @blip ||= radar.find_blip(params[:id])
    end

    def quadrants
      QuadrantList.names.each_with_object({}) do |item, result|
        result[item.titleize] = item
      end
    end

    def rings
      Blip::RINGS.each_with_object({}) do |item, result|
        result[item.titleize] = item
      end
    end

    def topics
      Topics::Blippable.call(radar).sort_by(&:name)
    end
  end
end
