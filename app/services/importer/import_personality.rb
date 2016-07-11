module Importer
  class ImportPersonality
    include CSVImporter

    model Target

    column :category_id, as: ["Theme1"], required: true
    column :constellation_id, as: ["ZodiacSignIndexKey"], required: true
    column :daum_id, as: ["Npc"], required: true
    column :favor_min, as: ["MinPv"], required: true
    column :favor_max, as: ["MaxPv"], required: true
    column :interest_min, as: ["MinDv"], required: true
    column :interest_max, as: ["MaxDv"], required: true

    identifier :daum_id

    when_invalid :abort
  end
end