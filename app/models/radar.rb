class Radar < ActiveRecord::Base
  belongs_to :owner, class_name: "User"
  has_many :blips, dependent: :delete_all

  validates :name, presence: true
  validates :owner, presence: true

  default_scope { order(updated_at: :desc) }

  def new_blip(params)
    blips.new(params)
  end

  def find_blip(id)
    blips.find(id)
  end

  def add_blip(params)
    blip = blips.new(params)
    blip.save!
    blip
  end

  def owned_by?(user)
    owner == user
  end
end
