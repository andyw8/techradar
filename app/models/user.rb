class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :radars, foreign_key: 'owner_id'

  def find_radar(id)
    radars.find(id)
  end

  def new_radar(params)
    radars.new(params)
  end
end
