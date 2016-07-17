require "csv"
require "rails_helper"

describe Importer::ImportRunner do
  describe "#import!" do
    let(:runner) { Importer::ImportRunner.new(path: "path") }

    before do
      mock!
    end

    context "cards" do
      it "imports cards" do
        reset_mock!(Importer::ImportCard)

        allow(File).to receive(:open) { double(read: data[:cards]) }

        runner.import!

        knowledge = Knowledge.first
        expect(Knowledge.count).to eq 1
        expect(knowledge.category_id).to eq 101
        expect(knowledge.daum_id).to eq 1
        expect(knowledge.favor_min).to eq 32
        expect(knowledge.favor_max).to eq 38
        expect(knowledge.interest).to eq 20
        expect(knowledge.name).to eq "아이슬린 바탈리"
      end
    end

    context "characters" do
      it "imports characters" do
        reset_mock!(Importer::ImportTarget)

        allow(File).to receive(:open) { double(read: data[:characters]) }

        runner.import!

        target = Target.first 
        expect(Target.count).to eq 1
        expect(target.daum_id).to eq 1001
        Globalize.with_locale(:ko) do
          expect(target.name).to eq "금속 가공 도구"
        end
      end
    end

    context "personalities" do
      it "imports personalities" do
        reset_mock!(Importer::ImportPersonality)

        allow(File).to receive(:open) { double(read: data[:personalities]) }

        runner.import!

        target = Target.first 
        expect(Target.count).to eq 1
        expect(target.category_id).to eq 101
        expect(target.constellation_id).to eq 601
        expect(target.daum_id).to eq 40001
        expect(target.favor_min).to eq 10
        expect(target.favor_max).to eq 14
        expect(target.interest_min).to eq 27
        expect(target.interest_max).to eq 29
      end
    end

    context "themes" do
      it "imports themes" do
        reset_mock!(Importer::ImportTheme)

        allow(File).to receive(:open) { double(read: data[:themes]) }

        runner.import!

        category = Category.first
        expect(Category.count).to eq 1
        expect(category.daum_id).to eq 1
        expect(category.name).to eq "인물"
      end
    end

    context "translations" do
      it "imports character translations" do
        reset_mock!(Importer::ImportCharacterTranslation)

        allow(File).to receive(:open) { double(read: data[:character_translations]) }

        runner.import!

        target = Target.first
        expect(target.name).to eq "Metal Processing Tool"
      end
    end

    context "zodiac" do
      it "imports zodiac" do
        reset_mock!(Importer::ImportZodiac)

        allow(File).to receive(:open) { double(read: data[:zodiac]) }

        runner.import!

        constellation = Constellation.first
        expect(Constellation.count).to eq 1
        expect(constellation.daum_id).to eq 1
        expect(constellation.name).to eq "망치자리"
      end

      it "imports zodiac index" do
        reset_mock!(Importer::ImportZodiacIndex)

        allow(File).to receive(:open) { double(read: data[:zodiac_index]) }

        runner.import!

        order = ConstellationOrder.first
        expect(ConstellationOrder.count).to eq 1
        expect(order.constellation_id).to eq 1
        expect(order.daum_id).to eq 101
        expect(order.slot_order).to eq [0, 1, 2, 3, 4, 5]
      end
    end
  end

  def data
    @data ||= {
      cards: CSV.generate do |csv|
        csv << %w(Key Name KnowledgeType KnowledgeLevel Picture MainTheme isGeneral MinDd MaxDd Hit BuffType VariedValue ApplyTurn ValidTurn Keyword position ContentsGroupKey)
        csv << [1, "아이슬린 바탈리", 0, 0, "UI_Artwork/IC_00001.dds", 101, 1, 32, 38, 20, nil, 4, 1, 4, "달무리 여관 여주인", nil, 0]
      end,
      character_translations: CSV.generate do |csv|
        csv << ["^Index", "~DisplayName", "", "note"]
        csv << [1001, "Metal Processing Tool", "", ""]
      end,
      characters: CSV.generate do |csv|
        csv << %w(Index DisplayName)
        csv << [1001, "금속 가공 도구"]
      end,
      personalities: CSV.generate do |csv|
        csv << %w(Npc NPC등급 NPC_Importance Theme1 NeedCount1 Theme2 NeedCount2 Theme3 NeedCount3 MinPv MaxPv MinDv MaxDv ZodiacSignIndexKey)
        csv << [40001, "D", 100000, 101, 7, 102, 7, 20101, 7, 10, 14, 27, 29, 601]
      end,
      themes: CSV.generate do |csv|
        csv << %w(Theme Name 표시용2 표시용1 Parent IncreaseWP NeedCount IncreaseWP2 NeedCount2 BookCase isCopyRightAble)
        csv << [1, "인물", 1, "", nil, 0, 0, 0, 0, nil, 0]
      end,
      zodiac: CSV.generate do |csv|
        csv << %w(ZodiacSignKey ZodiacName)
        csv << [1, "망치자리"]
      end,
      zodiac_index: CSV.generate do |csv|
        csv << %w(ZodiacSignIndexKey ZodiacSignKey Index0 Index1 Index2 Index3 Index4 Index5 Index6)
        csv << [101, 1, 0, 1, 2, 3, 4, 5, "<null>"]
      end
    }
  end

  def mock!
    allow(Importer::ImportCard).to receive(:new) { double(run!: nil) }
    allow(Importer::ImportPersonality).to receive(:new) { double(run!: nil) }
    allow(Importer::ImportTarget).to receive(:new) { double(run!: nil) }
    allow(Importer::ImportTheme).to receive(:new) { double(run!: nil) }
    allow(Importer::ImportZodiac).to receive(:new) { double(run!: nil) }
    allow(Importer::ImportZodiacIndex).to receive(:new) { double(run!: nil) }

    allow(Importer::ImportCharacterTranslation).to receive(:new) { double(run!: nil) }
  end

  def reset_mock!(obj)
    RSpec::Mocks.space.proxy_for(obj).reset
  end
end