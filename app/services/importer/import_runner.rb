module Importer
  class ImportRunner
    def initialize(path:)
      @path = path
    end

    def import!
      Globalize.with_locale(:ko) do
        ImportCard.new(path: "#{@path}/datasheets_Card.csv").run!
        ImportPersonality.new(path: "#{@path}/datasheets_Personality.csv").run!
        ImportTarget.new(path: "#{@path}/datasheets_Character.csv").run!
        ImportTheme.new(path: "#{@path}/datasheets_Theme.csv").run!
        ImportZodiac.new(path: "#{@path}/datasheets_ZodiacSign.csv").run!
        ImportZodiacIndex.new(path: "#{@path}/datasheets_ZodiacSignIndex.csv").run!
      end

      %i(en de fr).each do |locale|
        Globalize.with_locale(locale) do
          ImportCharacterTranslation.new(path: "#{@path}/languagedata_#{locale}_Character.csv").run!
          ImportCardTranslation.new(path: "#{@path}/languagedata_#{locale}_Card.csv").run!
          ImportThemeTranslation.new(path: "#{@path}/languagedata_#{locale}_Theme.csv").run!
          ImportZodiacTranslation.new(path: "#{@path}/languagedata_#{locale}_ZodiacSign.csv").run!
        end
      end
    end
  end
end