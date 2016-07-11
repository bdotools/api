module Importer
  class ImportRunner
    def initialize(path:)
      @path = path
    end

    def import!
      ImportPersonality.new(path: "#{@path}/datasheets_Personality.csv").run!
      ImportTarget.new(path: "#{@path}/datasheets_character.csv").run!
    end
  end
end