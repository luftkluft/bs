class AddItemTotalToCarts < ActiveRecord::Migration[5.2]
  def change
    change_column :carts, :order_total_price, :decimal, precision: 8, scale: 2, default: 0.0
    add_column :carts, :item_total_price, :decimal, precision: 8, scale: 2, default: 0.0
  end
end
