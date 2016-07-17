module Importer
  class ImportThemeTranslation
    include CSVImporter

    model Category

    column :daum_id, as: ["^Theme"], required: true
    column :name, as: ["~Name"], required: true

    identifier :daum_id
  end
end