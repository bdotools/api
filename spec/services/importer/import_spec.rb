require "rails_helper"
require "seven_zip_ruby"

describe Importer::Import do
  let(:import) { Importer::Import.new(path: "path") }

  describe "#call" do
    let(:szr) { double(extract_all: nil) }
    let(:uuid) { "abc" }

    before do
      mock!
    end

    it "should call import runner with the results" do
      runner = double(import!: nil)
      allow(Importer::ImportRunner).to receive(:new) { runner }

      import.call

      expect(Importer::ImportRunner).to have_received(:new).with(path: "#{Rails.root}/tmp/importer/#{uuid}")
      expect(runner).to have_received(:import!)
    end
  end

  def mock!
    allow(File).to receive(:open) { |&block| block.yield if block }
    allow(SecureRandom).to receive(:uuid) { uuid }
    allow(SevenZipRuby::Reader).to receive(:open) { |&block| block.yield(szr) if block }
  end
end
