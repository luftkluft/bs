class AddPuBooksToUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :purchased_books, :integer
    add_column :users, :purchased_books, :integer, array: true, default: []
  end
end
