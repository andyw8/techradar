class BlipsController < ApplicationController
  before_action :find_radar, except: :index
  before_action :find_blip, only: [:edit, :show, :destroy, :update]

  def new
    @blip = @radar.new_blip({})
  end

  def create
    @blip = @radar.new_blip(blip_params)
    if @blip.save
      redirect_to @radar
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @blip.update(blip_params)
      redirect_to @radar, notice: "Blip updated"
    else
      render 'edit'
    end
  end

  def destroy
    @blip.destroy!
    redirect_to @radar
    # can I use @blip.radar?
  end

  private

  def blip_params
    params.require(:blip).permit(:name, :quadrant, :ring, :notes)
  end

  def find_radar
    @radar = current_user.find_radar(params[:radar_id])
  end

  def find_blip
    @blip = @radar.find_blip(params[:id])
  end
end
