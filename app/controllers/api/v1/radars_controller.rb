module Api
  module V1
    class RadarsController < ApplicationController
      def show
        @radar = Radar.lookup_for_owner(params[:id], current_user)
        render json: @radar
      end
    end
  end
end
