module Importer
  class ImportCardTranslation
    include CSVImporter

    model Knowledge

    column :daum_id, as: ["^Key"], required: true
    column :name, as: ["~Name"], required: true

    identifier :daum_id
  end
end