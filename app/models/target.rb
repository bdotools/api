class Target < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :constellation, optional: true

  has_many :knowledges, through: :category
  has_many :results

  delegate :slots, :slot_order, to: :constellation, prefix: true
end
