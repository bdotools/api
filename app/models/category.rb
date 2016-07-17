class Category < ApplicationRecord
  has_many :knowledges, primary_key: :daum_id
  has_many :targets, primary_key: :daum_id

  translates :name
end
