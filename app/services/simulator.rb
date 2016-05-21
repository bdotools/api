class Simulator
  Combo = Struct.new(:combo_delay, :combo_length, :combo_interest, :combo_favor)

  class Status
    attr_accessor :combo_effects, :target_favor, :target_interest

    def initialize(target_favor, target_interest)
      @accumulated_favor = 0
      @combo_effects = []
      @consecutive_failures = 0
      @consecutive_sparks = 0
      @current_max_favor = 0
      @sparks = 0
      @target_favor = target_favor
      @target_interest = target_interest
    end

    def add_combination(knowledge)
      combo_effects << Simulator::Combo.new(
        knowledge.combo_delay,
        knowledge.combo_length,
        knowledge.combo_interest,
        knowledge.combo_favor
      )
    end

    def adjusted_interest
      adjusted = target_interest - combo_effects.map(&:combo_interest).inject(:+).to_i

      if adjusted > 0
        adjusted.to_f
      else
        1.0
      end
    end

    def clear_expired_combinations(round)
      combo_effects.delete_if { |x| x.combo_delay + x.combo_length >= round }
    end
  end

  GOALS = {
    spark: { min: 1, max: 8 },
    spark_failure: { min: 1, max: 8 },
    consecutive_spark: { min: 1, max: 8 },
    consecutive_failure: { min: 1, max: 8 },
    accumulated_favor: { min: 1, max: 250 },
    max_favor: { min: 1, max: 150 },
    free_talk: { min: 0, max: 0 }
  }

  def initialize(target)
    @target = target
  end

  def call
    permutations = target.knowledges.to_a.permutation(target.constellation.slots)

    puts "Simulating #{permutations.size} combinations"

    permutations.each do |permutation|
      simulate(permutation)
    end
  end

  private

  def accumulate_ev(goal)
    case goal
      when :spark
      when :spark_failure
      when :consecutive_spark
      when :consecutive_failure
      when :accumulated_favor
      when :max_favor
      when :free_talk
    end
  end

  def goals
    GOALS
  end

  def simulate(permutation)
    target_values = [*target.favor_min..target.favor_max].product([*target.interest_min..target.interest_max])

    target_values.each do |favor, interest|
      @status = Status.new(favor, interest)

      slots.times do |round|
        simulate_round(round, permutation)
      end
    end

    # goals.each do |goal, opts|
    #   [*opts[:min]..opts[:max]].each do |goal_param|
    #   end
    #
    #   # accumulate ev
    # end
  end

  def simulate_round(n, permutation)
    knowledge = permutation[slot_order[n]]

    status.clear_expired_combinations(n)

    if knowledge.combo_delay == n
      status.add_combination(knowledge)
    end

    spark_chance = knowledge.interest / status.adjusted_interest
    interest_gain = [1, knowledge.average_favor - status.target_favor].max

    # spark
    # fail
  end

  def slots
    target.constellation_slots
  end

  def slot_order
    target.constellation_slot_order
  end

  def status
    @status
  end

  def target
    @target
  end
end