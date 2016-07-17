class AddTranslations < ActiveRecord::Migration[5.0]
  def up
    Target.create_translation_table!(name: :string)
  end

  def down
    Target.drop_translation_table!
  end
end
