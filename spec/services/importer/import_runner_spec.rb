require "csv"
require "rails_helper"

describe Importer::ImportRunner do
  describe "#import!" do
    let(:runner) { Importer::ImportRunner.new(path: "path") }

    before do
      mock!
    end

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

    it "imports characters" do
      reset_mock!(Importer::ImportTarget)

      allow(File).to receive(:open) { double(read: data[:characters]) }

      runner.import!

      target = Target.first 
      expect(Target.count).to eq 1
      expect(target.daum_id).to eq 1001
      expect(target.name).to eq "금속 가공 도구"
    end
  end

  def data
    @data ||= {
      characters: CSV.generate do |csv|
        csv << %w(Index DisplayName)
        csv << [1001, "금속 가공 도구"]
      end,
      personalities: CSV.generate do |csv|
        csv << %w(Npc NPC등급 NPC_Importance Theme1 NeedCount1 Theme2 NeedCount2 Theme3 NeedCount3 MinPv MaxPv MinDv MaxDv ZodiacSignIndexKey)
        csv << %w(40001 D 100000 101 7 102 7 20101 7 10 14 27 29 601)
      end
    }
  end

  def mock!
    allow(Importer::ImportPersonality).to receive(:new) { double(run!: nil) }
    allow(Importer::ImportTarget).to receive(:new) { double(run!: nil) }
  end

  def reset_mock!(obj)
    RSpec::Mocks.space.proxy_for(obj).reset
  end
end