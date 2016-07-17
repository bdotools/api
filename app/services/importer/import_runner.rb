module Importer
  class ImportRunner
    def initialize(path:)
      @path = path
    end

    def import!
      Globalize.with_locale(:ko) do
        ImportCard.new(path: "#{@path}/datasheets_Card.csv").run!
        ImportPersonality.new(path: "#{@path}/datasheets_Personality.csv").run!
        ImportTarget.new(path: "#{@path}/datasheets_character.csv").run!
        ImportTheme.new(path: "#{@path}/datasheets_Theme.csv").run!
        ImportZodiac.new(path: "#{@path}/datasheets_ZodiacSign.csv").run!
        ImportZodiacIndex.new(path: "#{@path}/datasheets_ZodiacSignIndex.csv").run!
      end

      Globalize.with_locale(:en) do
        ImportCharacterTranslation.new(path: "#{@path}/languagedata_en_Character.csv").run!
      end
    end
  end
end