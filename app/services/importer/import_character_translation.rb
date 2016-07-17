module Importer
  class ImportCharacterTranslation
    include CSVImporter

    model Target

    column :daum_id, as: ["^Index"], required: true
    column :name, as: ["~DisplayName"], required: true

    identifier :daum_id
  end
end