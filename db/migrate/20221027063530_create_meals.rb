class CreateMeals < ActiveRecord::Migration[7.0]
  def change
    create_table :meals do |t|
      t.string :name
      t.datetime :day_at
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
