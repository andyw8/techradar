module Radars
  class BlipsController < ApplicationController
    def new
      @blip = radar.new_blip({})
      locals
    end

    def create
      @blip = radar.new_blip(blip_params)
      if blip.save
        redirect_to radar
      else
        locals 'new'
      end
    end

    def show
      locals
    end

    def edit
      locals
    end

    def update
      if blip.update(blip_params)
        redirect_to radar, notice: "Blip updated"
      else
        locals 'edit'
      end
    end

    def destroy
      blip.destroy!
      redirect_to radar
    end

    private

    def locals(template = nil)
      render template, locals: { quadrants: quadrants, rings: rings, blip: blip, blips: blips }
    end

    def blip_params
      params.require(:blip).permit(:name, :quadrant, :ring, :notes)
    end

    def radar
      @radar ||= current_user.find_radar(params[:radar_id])
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

    def blips
      Blip.order(:name).map(&:name)
    end
  end
end
