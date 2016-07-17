class AddTranslations < ActiveRecord::Migration[5.0]
  def up
    Category.create_translation_table!(name: :string)
    Constellation.create_translation_table!(name: :string)
    Knowledge.create_translation_table!(name: :string)
    Target.create_translation_table!(name: :string)
  end

  def down
    Category.drop_translation_table!
    Constellation.drop_translation_table!
    Knowledge.drop_translation_table!
    Target.drop_translation_table!
  end
end
