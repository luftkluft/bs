class AddCheckoutStepsToCarts < ActiveRecord::Migration[5.2]
  def change
    add_column :carts, :checkout_step, :string, default: ''
  end
end
