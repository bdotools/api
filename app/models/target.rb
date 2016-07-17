class Target < ApplicationRecord
  include Workflow

  belongs_to :category, primary_key: :daum_id, optional: true
  belongs_to :constellation_order, primary_key: :daum_id, foreign_key: :constellation_id, optional: true

  has_one :constellation, through: :constellation_order

  has_many :knowledges, through: :category
  has_many :results

  delegate :name, to: :constellation, prefix: true
  delegate :slots, :slot_order, to: :constellation_order, prefix: :constellation

  translates :name

  workflow do
    state :hidden
    state :available
  end

  def queue_for_update
    [*interest_min..interest_max].product([*favor_min..favor_max]).each do |combination|
      SolverJob.perform_later(id, combination.first, combination.last)
    end
  end
end
