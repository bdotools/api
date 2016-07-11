require "rails_helper"

describe Importer::ImportTarget do
  describe ".import" do
    it "returns a new instance with the path set" do
      instance = Importer::ImportTarget.import(path: "path")

      expect(instance.path).to eq "path"
    end
  end
end