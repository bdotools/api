class AddExperimentalToResults < ActiveRecord::Migration[5.0]
  def change
    add_column :results, :experimental, :boolean, default: false
  end
end
