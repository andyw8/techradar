class User < ActiveRecord::Base
  THOUGHTWORKS_EMAIL = "thoughtworks@techradar.io"

  MissingAdminAccount = Class.new(RuntimeError)

  include Wisper::Publisher

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :radars, foreign_key: "owner_id"
  has_many :topics, foreign_key: "creator_id"

  def find_radar(uuid:)
    radars.find_by!(uuid: uuid)
  end

  def new_radar(params)
    radars.new(params)
  end

  def add_radar(params)
    new_radar(params).tap(&(:save!))
  end

  def first_sign_in?
    sign_in_count == 1
  end

  after_create do |user|
    publish(:user_created, user)
  end

  def self.admin
    admin = find_by(admin: true)
    admin || fail(MissingAdminAccount)
  end

  def self.thoughtworks
    find_by!(email: THOUGHTWORKS_EMAIL)
  end


end
