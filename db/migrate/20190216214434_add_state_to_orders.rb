class AddStateToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :delivery_id, :integer
    add_column :orders, :state, :string
  end
end
