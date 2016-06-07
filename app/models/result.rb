class Result < ApplicationRecord
  attr_accessor :current_ip

  belongs_to :target

  has_many :votes

  def downvotes
    votes.where(value: -1).count
  end

  def upvotes
    votes.where(value: 1).count
  end

  def voted
    votes.where(ip: current_ip).any?
  end
end
