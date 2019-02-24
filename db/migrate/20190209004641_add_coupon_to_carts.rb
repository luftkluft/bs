class AddCouponToCarts < ActiveRecord::Migration[5.2]
  def change
    add_column :carts, :coupon, :decimal, default: 0.0
  end
end
