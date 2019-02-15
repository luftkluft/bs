class AddPolymorphicToDeliveries < ActiveRecord::Migration[5.2]
  def change
    add_column :deliveries, :deliveryable_id, :integer
    add_column :deliveries, :deliveryable_type, :string
    add_index :deliveries, [:deliveryable_type, :deliveryable_id]
  end
end
