class AddWorkflowStateToTargets < ActiveRecord::Migration[5.0]
  class MigrationTarget < ApplicationRecord
    self.table_name = "targets"
  end

  def change
    add_column :targets, :workflow_state, :string, default: :hidden

    MigrationTarget.update_all(workflow_state: :available)
  end
end
