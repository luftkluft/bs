class AddPurchasedBooksToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :purchased_books, :integer, array: true
  end
end
