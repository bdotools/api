class TargetSerializer < ActiveModel::Serializer
  attributes :id, :name, :favor_min, :favor_max, :interest_min, :interest_max

  belongs_to :category
  belongs_to :constellation

  has_many :knowledges
end
