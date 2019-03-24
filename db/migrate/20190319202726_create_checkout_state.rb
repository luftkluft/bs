class CreateCheckoutState < ActiveRecord::Migration[5.2]
  def change
    create_table :checkout_states do |t|
      t.string :message, default: ''
      t.string :state
    end
  end
end
