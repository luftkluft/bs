class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :address_type
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :city
      t.integer :zip
      t.string :country
      t.string :phone

      t.timestamps
    end
  end
end
