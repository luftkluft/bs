class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.decimal :order_total_price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
