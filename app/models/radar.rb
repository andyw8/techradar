class Radar < ApplicationRecord
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

  def self.lookup(uuid)
    find_by!(uuid: uuid)
  end

  def self.lookup_for_owner(uuid, owner)
    find_by(uuid: uuid, owner: owner)
  end

  def find_blip(slug)
    blips.joins(:topic).find_by!("topics.slug": slug)
  end

  def owned_by?(user)
    owner == user
  end

  def to_param
    uuid
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
