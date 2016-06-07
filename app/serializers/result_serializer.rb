class ResultSerializer < ActiveModel::Serializer
  attributes :id, :downvotes, :experimental, :knowledge_ids, :outdated, :success_percentage, :upvotes, :voted
end
