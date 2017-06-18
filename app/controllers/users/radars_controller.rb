module Users
  class RadarsController < ApplicationController
    def index
      user = User.find_by(username: params[:user_username])
      radars = user.radars
      render 'index', locals: {user: user, radars: radars }
    end
  end
end
