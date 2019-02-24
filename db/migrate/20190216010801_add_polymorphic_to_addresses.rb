class AddPolymorphicToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :addressable_id, :integer
    add_column :addresses, :addressable_type, :string
    add_index :addresses, [:addressable_type, :addressable_id]
    add_column :addresses, :order_id, :integer, default: 0
  end
end
