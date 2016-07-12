class AddDaumIdToConstellation < ActiveRecord::Migration[5.0]
  def change
    add_column :constellations, :daum_id, :integer
    add_index :constellations, :daum_id, unique: true
  end
end
