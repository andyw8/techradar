class Topic < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :slug, presence: true, uniqueness: true

  has_many :blips
  has_many :radars, through: :blips

  belongs_to :creator, class_name: 'User'

  def self.techradar
    # TODO do in test setup to avoid running for every spec?
    find_or_create_by(name: "techradar.io")
  end
end
