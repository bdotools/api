class Importer
  def initialize(json)
    @data = JSON.parse(json)
    @category_map = {}
    @knowledge_map = {}
  end

  def call
    process_knowledge
    process_categories
    process_targets
  end

  private

  def data
    @data
  end

  def handle_combination(knowledge, card)
    return unless card["apply_turn"]

    knowledge.combo_delay = card["apply_turn"] + 1
    knowledge.combo_length = card["valid_turn"]

    if card["buff_type"] == 0
      knowledge.combo_favor = card["varied_value"]
    elsif card["buff_type"] == 1
      knowledge.combo_interest = card["varied_value"]
    end
  end

  def process_categories
    data["themes"].each do |theme|
      c = Category.find_or_create_by!(name: theme["name"])

      theme["cards"].each do |card_id|
        c.knowledges << @knowledge_map[card_id]
      end

      c.save!

      @category_map[theme["id"]] = c
    end
  end

  def process_knowledge
    data["card"].each do |card|
      k = Knowledge.find_or_create_by!(name: card["name"])

      k.favor_min = card["min_favor"]
      k.favor_max = card["max_favor"]
      k.interest = card["interest"]

      handle_combination(k, card)

      k.save!

      @knowledge_map[card["id"]] = k
    end

    process_old
  end

  def process_old
    ids = @knowledge_map.map { |_, v| v["id"] }
    old = Array(Knowledge.where.not(id: ids).pluck(:id))

    if old.any?
      Knowledge.where(id: old).delete_all
      Result.where("ARRAY#{old} && knowledge_ids").delete_all
    end
  end

  def process_targets
    data["personality"].each do |personality|
      t = Target.find_or_create_by!(name: personality["name"])
      c = Constellation.find_by(name: "#{personality["zodiac"]} (#{personality["name"]})") || Constellation.find_by(name: personality["zodiac"])

      t.favor_min = personality["min_favor"]
      t.favor_max = personality["max_favor"]

      t.interest_min = personality["min_interest"]
      t.interest_max = personality["max_interest"]

      t.category = @category_map[personality["theme"]]
      t.constellation = c

      t.save!
    end
  end
end
