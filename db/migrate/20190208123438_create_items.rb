class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :book, foreign_key: true
      t.references :cart, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
