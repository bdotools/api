require "seven_zip_ruby"

module Importer
  class Import
    def initialize(path:)
      @path = path
    end

    def call
      uuid = SecureRandom.uuid
      extraction_path = "#{Rails.root}/tmp/importer/#{uuid}"

      File.open(@path, "rb") do |file|
        SevenZipRuby::Reader.open(file) do |szr|
          szr.extract_all extraction_path
        end
      end

      ImportRunner.new(path: extraction_path).import!
    end
  end
end