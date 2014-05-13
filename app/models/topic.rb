class Topic < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true

  has_many :blips
  has_many :radars, through: :blips
end
