class BlipsController < ApplicationController
  def new
    blip = radar.new_blip({})
    render locals: { quadrants: quadrants, rings: rings, blip: blip, radar: radar }
  end

  def create
    blip = radar.new_blip(blip_params)
    if blip.save
      redirect_to radar
    else
      render 'new', locals: { quadrants: quadrants, rings: rings, blip: blip, radar: radar }
    end
  end

  def show
    render locals: { blip: blip }
  end

  def edit
    render locals: { quadrants: quadrants, rings: rings, blip: blip }
  end

  def update
    if blip.update(blip_params)
      redirect_to radar, notice: "Blip updated"
    else
      render 'edit', locals: { quadrants: quadrants, rings: rings, blip: blip, radar: radar }
    end
  end

  def destroy
    blip.destroy!
    redirect_to radar
    # can I use @blip.radar?
  end

  private

  def blip_params
    params.require(:blip).permit(:name, :quadrant, :ring, :notes)
  end

  def radar
    @radar = current_user.find_radar(params[:radar_id])
  end

  def blip
    @blip = radar.find_blip(params[:id])
  end

  def quadrants
    Blip::QUADRANTS.inject({}) {|result, item| result[item.titleize] = item; result }
  end

  def rings
    Blip::RINGS.inject({}) {|result, item| result[item.titleize] = item; result }
  end
end
