class ChangeOutdatedDefaultForResults < ActiveRecord::Migration[5.0]
  def change
    change_column_default :results, :outdated, false
  end
end
