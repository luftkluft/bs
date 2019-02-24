class AddDeliveryIdToCarts < ActiveRecord::Migration[5.2]
  def change
    add_column :carts, :delivery_id, :integer
  end
end
