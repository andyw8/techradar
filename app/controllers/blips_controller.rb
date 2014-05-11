class BlipsController < ApplicationController
  def index
    render locals: { blips: Blip.includes(:topic).order(:name) }
  end

  def show
    blip = Blip.find(params[:id])
    render locals: { blip: blip }
  end
end
