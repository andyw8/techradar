module Radars
  class BlipsController < ApplicationController
    def new
      @blip = radar.new_blip(params[:blip])
      render "new", locals: { quadrants: quadrants, rings: rings, blip: blip, topics: topics }
    end

    def create
      @blip = radar.new_blip(blip_params)
      if @blip.save
        redirect_to radar
      else
        render "new", locals: { quadrants: quadrants, rings: rings, blip: blip, topics: topics }
      end
    end

    def show
      render "show", locals: { quadrants: quadrants, rings: rings, blip: blip.decorate, topics: topics }
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
      @radar ||= current_user.find_radar(uuid: params[:radar_id])
    end

    def blip
      @blip ||= radar.find_blip(params[:id])
    end

    def quadrants
      Blip::QUADRANTS.each_with_object({}) do |item, result|
        result[item.titleize] = item
      end
    end

    def rings
      Blip::RINGS.each_with_object({}) do |item, result|
        result[item.titleize] = item
      end
    end

    def topics
      current_user.topics.by_name
    end
  end
end
