class TargetSerializer < ActiveModel::Serializer
  attributes :id, :combinations, :name

  belongs_to :category
  belongs_to :constellation

  has_many :knowledges
end
