class Knowledge < ApplicationRecord
  belongs_to :category, primary_key: :daum_id, optional: true

  translates :name

  def average_favor
    @average_favor ||= (favor_min + favor_max) / 2
  end
end
