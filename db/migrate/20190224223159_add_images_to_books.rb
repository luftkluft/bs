class AddImagesToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :image_1, :string
    add_column :books, :image_2, :string
    add_column :books, :image_3, :string
  end
end
