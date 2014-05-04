class Radar < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_many :blips, dependent: :delete_all

  validates :name, presence: true
  validates :owner, presence: true

  def new_blip(params)
    blips.new(params)
  end

  def find_blip(id)
    blips.find(id)
  end
end
