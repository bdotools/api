class Category < ApplicationRecord
  has_many :knowledges
  has_many :targets
end
