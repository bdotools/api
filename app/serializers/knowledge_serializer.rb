class KnowledgeSerializer < ActiveModel::Serializer
  attributes :id, :name, :favor_min, :favor_max, :interest
end