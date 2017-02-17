class RadarSerializer < ActiveModel::Serializer
  attributes :name
  has_many :blips
end
