class CreateDeliveries < ActiveRecord::Migration[5.2]
  def change
    create_table :deliveries do |t|
      t.string :method
      t.string :duration
      t.decimal :price, precision: 8, scale: 2, default: 0.0
      t.references :cart, foreign_key: true

      t.timestamps
    end
  end
end
