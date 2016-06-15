class Knowledge < ApplicationRecord
  belongs_to :category, optional: true

  def average_favor
    @average_favor ||= (favor_min + favor_max) / 2
  end
end
