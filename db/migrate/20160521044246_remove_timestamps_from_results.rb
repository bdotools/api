class RemoveTimestampsFromResults < ActiveRecord::Migration[5.0]
  def change
    remove_column :results, :created_at
    remove_column :results, :updated_at
  end
end
