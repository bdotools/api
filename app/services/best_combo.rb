class BestCombo
  attr_reader :favor, :interest, :order, :result, :target

  def initialize(id:, interest:, favor:, order: :desc)
    @favor = favor.to_i
    @interest = interest.to_f
    @order = order
    @target = Target.eager_load(:knowledges).find(id)
  end

  def is_asc?
    order == :asc
  end

  def result
    knowledges = target.knowledges
    if !is_asc?
      knowledges = knowledges.select { |x| x.calculated_interest(favor) > 0 }
      if knowledges.count < target.constellation_slots
        knowledges = target.knowledges
      end
    end

    @result ||= target.knowledges.select { |x| x.calculated_interest(favor) > 0 }.sort do |a, b|
      first, second = [-a.interest, -b.interest]
      if is_asc?
        first = -first
        second = -second
      end

      comp = (first <=> second)
      comp.zero? ? (-a.calculated_interest(favor) <=> -b.calculated_interest(favor)) : comp
    end

    @result.first(target.constellation_slots)
  end

  def success_chance
    total = result.inject(0) do |sum, k|
      sum += k.interest / interest
    end

    chance = [total / target.constellation_slots, 1].min

    if order == :asc
      #1 - chance
      nil
    else
      chance
    end
  end

  def to_json(*)
    # attributes :id, :downvotes, :experimental, :knowledge_ids, :outdated, :success_percentage, :upvotes, :voted
    {
      experimental: true,
      knowledge_ids: result.map(&:id),
      success_percentage: success_chance
    }.to_json
  end
end