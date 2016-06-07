class AddOutdatedToResults < ActiveRecord::Migration[5.0]
  def change
    add_column :results, :outdated, :boolean, default: true
  end
end
