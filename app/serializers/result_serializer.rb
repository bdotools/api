class ResultSerializer < ActiveModel::Serializer
  attributes :id, :knowledge_ids, :outdated, :success_percentage
end
