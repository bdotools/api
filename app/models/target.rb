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

  def combinations
    results.select("distinct on (target_interest, target_favor) target_interest, target_favor, outdated").each_with_object({}) do |result, hash|
      obj = hash[result.target_interest] ||= {}
      obj[:outdated] = true if result.outdated
      obj[:data] ||= []
      obj[:data] << result.target_favor
    end
  end

  def outdated
    results.where(outdated: true).any?
  end

  def queue_for_update
    [*interest_min..interest_max].product([*favor_min..favor_max]).each do |combination|
      SolverJob.perform_later(id, combination.first, combination.last)
    end
  end
end
