class CreateParticipates < ActiveRecord::Migration[7.0]
  def change
    create_table :participates do |t|
      t.references :user, null: false, foreign_key: true
      t.references :meal, null: false, foreign_key: true

      t.timestamps
    end
  end
end
