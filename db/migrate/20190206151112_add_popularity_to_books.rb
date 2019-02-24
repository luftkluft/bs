class AddPopularityToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :popularity, :integer, default: 0
  end
end
