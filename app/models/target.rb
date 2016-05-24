class Target < ApplicationRecord
  include Workflow

  belongs_to :category, optional: true
  belongs_to :constellation, optional: true

  has_many :knowledges, through: :category
  has_many :results

  delegate :slots, :slot_order, to: :constellation, prefix: true

  workflow do
    state :hidden
    state :available
  end
end
