class ResultSerializer < ActiveModel::Serializer
  attributes :id, :downvotes, :experimental, :knowledge_ids, :outdated, :upvotes, :voted
end
