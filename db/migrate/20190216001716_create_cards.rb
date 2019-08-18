class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string :card_number
      t.string :name
      t.integer :cvv
      t.string :expiration_month_year
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
