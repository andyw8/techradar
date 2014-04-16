class RadarsController < ApplicationController
  def index
    @radars = Radar.all
  end
end
