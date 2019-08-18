class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :description
      t.string :image
      t.string :materials
      t.decimal :price, precision: 8, scale: 2
      t.decimal :height
      t.decimal :width
      t.decimal :depth
      t.integer :year
      t.integer :in_stock
      t.string :author

      t.timestamps
    end
  end
end
