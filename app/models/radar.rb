class Radar < ActiveRecord::Base
  belongs_to :owner, class_name: "User"
  has_many :blips, dependent: :delete_all

  validates :name,
            presence: true,
            uniqueness: {
              scope: :owner,
              case_sensitive: false
            }
  validates :owner, presence: true
  validates :uuid, presence: true, uniqueness: true

  before_validation :set_uuid, on: :create

  default_scope { order(updated_at: :desc) }

  attr_accessor :topics

  def new_blip(params)
    blips.new(params)
  end

  def find_blip(slug)
    blips.joins(:topic).find_by!("topics.slug": slug)
  end

  def blips_in_quadrant(quadrant)
    blips.where(quadrant: quadrant)
  end

  def blips_in_ring(ring)
    blips.where(ring: ring)
  end

  def blips_in_scope(ring:, quadrant:)
    blips.includes(:topic).where(ring: ring, quadrant: quadrant).order("topics.name")
  end

  def add_blip(params)
    blip = blips.new(params)
    blip.save!
    blip
  end

  def owned_by?(user)
    owner == user
  end

  def to_param
    uuid
  end

  def blips_in_quadrant_count(quadrant)
    blips.where(quadrant: quadrant).count
  end

  def topic?(topic)
    blips.any? do |blip|
      blip.topic == topic
    end
  end

  private

  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end
