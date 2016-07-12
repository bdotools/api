module Importer
  class ImportCard
    include CSVImporter

    model Knowledge

    column :category_id, as: ["MainTheme"], required: true
    column :daum_id, as: ["Key"], required: true
    column :favor_min, as: ["MinDd"], required: true
    column :favor_max, as: ["MaxDd"], required: true
    column :interest, as: ["Hit"], required: true
    column :name, as: ["Name"], required: true

    identifier :daum_id

    when_invalid :abort
  end
end