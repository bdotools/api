require "rails_helper"

describe Importer do
  context "knowledge" do
    it "creates missing knowledge" do
      expect { importer.call }.to change(Knowledge, :count).by(1)
    end

    it "updates existing knowledge" do
      knowledge = FactoryGirl.create(:knowledge, name: "Hans")

      importer.call

      knowledge.reload
      expect(knowledge.favor_min).to eq 25
      expect(knowledge.favor_max).to eq 30
      expect(knowledge.interest).to eq 26
      expect(knowledge.combo_delay).to eq 5
      expect(knowledge.combo_length).to eq 1
      expect(knowledge.combo_interest).to eq 4
    end

    it "removes unused knowledge" do
      knowledge = FactoryGirl.create(:knowledge, name: "Hans 2")

      importer.call

      expect(Knowledge.count).to eq 1
    end

    it "removes results for unused knowledge" do
      knowledge = FactoryGirl.create(:knowledge, name: "Hans 2")
      result = FactoryGirl.create(:result, knowledge_ids: [knowledge.id])

      importer.call

      expect(Result.count).to eq 0
    end
  end

  context "categories" do
    it "creates missing categories" do
      expect { importer.call }.to change(Category, :count).by(1)
    end

    it "associates knowledge with category" do
      category = FactoryGirl.create(:category, name: "Velia Villagers")
      knowledge = FactoryGirl.create(:knowledge, name: "Hans")

      importer.call

      expect(category.knowledges).to eq [knowledge]
    end
  end

  context "targets" do
    it "creates missing targets" do
      expect { importer.call }.to change(Target, :count).by(1)
    end

    it "updates existing targets" do
      target = FactoryGirl.create(:target, name: "Hans")

      importer.call

      target.reload
      expect(target.favor_min).to eq 19
      expect(target.favor_max).to eq 52
      expect(target.interest_min).to eq 10
      expect(target.interest_max).to eq 61
    end

    it "associates target with category" do
      category = FactoryGirl.create(:category, name: "Velia Villagers")
      target = FactoryGirl.create(:target, name: "Hans")

      importer.call

      expect(category.targets).to eq [target]
    end
  end

  def json
    {
      "card": [
        {
          "apply_turn": 4,
          "buff_type": 1,
          "id": 58,
          "interest": 26,
          "max_favor": 30,
          "min_favor": 25,
          "name": "Hans",
          "valid_turn": 1,
          "varied_value": 4
        }
      ],
      "personality": [
        {
          "id": 58,
          "max_favor": 52,
          "max_interest": 61,
          "min_favor": 19,
          "min_interest": 10,
          "name": "Hans",
          "theme": 101,
          "zodiac": "Hammer"
        }
      ],
      "themes": [
        {
          "cards": [ 58 ],
          "id": 101,
          "name": "Velia Villagers"
        }
      ]
    }.to_json
  end

  def importer
    Importer.new(json)
  end
end
