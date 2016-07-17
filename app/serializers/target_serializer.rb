class TargetSerializer < ActiveModel::Serializer
  attributes :id, :favor_min, :favor_max, :interest_min, :interest_max, :name

  belongs_to :category
  belongs_to :constellation

  has_many :knowledges
end
