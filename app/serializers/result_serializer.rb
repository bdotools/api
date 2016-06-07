class ResultSerializer < ActiveModel::Serializer
  attributes :id, :experimental, :knowledge_ids, :outdated, :success_percentage
end
