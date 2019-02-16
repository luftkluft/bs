class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string   :invoice
      t.decimal :item_total_price, precision: 8, scale: 2
      t.decimal :order_total_price, precision: 8, scale: 2
      t.decimal :coupon, precision: 8, scale: 2
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
