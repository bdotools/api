module Importer
  class ImportTarget
    include CSVImporter

    model Target

    column :daum_id, as: ["Index"], required: true
    column :name, as: ["DisplayName"], required: true

    identifier :daum_id

    def self.import(path:)
      new(path: path)
    end

    def path
      csv.path
    end
  end
end