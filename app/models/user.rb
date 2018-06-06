class User < ApplicationRecord
  MissingAdminAccount = Class.new(RuntimeError)

  include Wisper::Publisher

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :radars, foreign_key: "owner_id", dependent: :destroy
  has_many :created_topics, foreign_key: "creator_id", class_name: "Topic", dependent: :nullify
  has_many :blips, through: :radars

  attr_accessor :login

  validates :name, presence: true
  validates :username,
            presence: true,
            uniqueness: {
              case_sensitive: false
            }

  # For Devise
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions).find_by(["lower(username) = :value OR lower(email) = :value", { value: login.downcase }])
    else
      # :nocov:
      find_by(conditions)
      # :nocov:
    end
  end

  # Override Devise to use ActiveJob
  # https://github.com/plataformatec/devise#activejob-integration
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def find_radar(uuid:)
    radars.find_by!(uuid: uuid)
  end

  def new_radar(params)
    radars.new(params)
  end

  def add_radar(params)
    new_radar(params).tap(&:save!)
  end

  def first_sign_in?
    sign_in_count == 1
  end

  after_create do |user|
    publish(:user_created, user)
  end

  def self.admin
    admin = find_by(admin: true)
    admin || raise(MissingAdminAccount)
  end
end
