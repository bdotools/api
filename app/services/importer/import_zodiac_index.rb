module Importer
  class ImportZodiacIndex
    include CSVImporter

    model ConstellationOrder

    column :indices, as: [/\AIndex\d{1}+\z/], to: ->(order, model) do
      return if order.nil? || order == "<null>"
      model.slot_order << order
    end
    column :constellation_id, as: ["ZodiacSignKey"], required: true
    column :daum_id, as: ["ZodiacSignIndexKey"], required: true

    identifier :daum_id
  end
end