class AddVersionToResults < ActiveRecord::Migration[5.0]
  def change
    add_column :results, :version, :integer
  end
end
