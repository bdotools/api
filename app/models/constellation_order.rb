class ConstellationOrder < ApplicationRecord
  attr_accessor :indices

  belongs_to :constellation, primary_key: :daum_id, optional: true

  def slots
    slot_order.uniq.count
  end
end