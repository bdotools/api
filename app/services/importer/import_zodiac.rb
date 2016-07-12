module Importer
  class ImportZodiac
    include CSVImporter

    model Constellation

    column :daum_id, as: ["ZodiacSignKey"], required: true
    column :name, as: ["ZodiacName"], required: true

    identifier :daum_id
  end
end