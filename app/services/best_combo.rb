class BestCombo
  attr_reader :interest, :order, :result, :target

  def initialize(id:, interest:, order: :desc)
    @interest = interest.to_f
    @order = order
    @target = Target.eager_load(:knowledges).find(id)
  end

  def is_asc?
    order == :asc
  end

  def result
    @result ||= target.knowledges.sort do |a, b|
      first, second = [-a.interest, -b.interest]
      if is_asc?
        first = -first
        second = -second
      end

      comp = (first <=> second)
      comp.zero? ? (-a.average_favor <=> -b.average_favor) : comp
    end

    @result.first(target.constellation_slots)
  end

  def success_chance
    total = result.inject(0) do |sum, k|
      sum += k.interest / interest
    end

    [total / target.constellation_slots, 1].min
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