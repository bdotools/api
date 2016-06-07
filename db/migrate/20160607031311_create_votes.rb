class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.integer :value
      t.inet :ip
      t.references :result, foreign_key: true

      t.timestamps
    end
  end
end
