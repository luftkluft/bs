class ChangeColumnInBooks < ActiveRecord::Migration[5.2]
  def change
    change_column(:books, :description, :text)
    change_column(:books, :author, :text)
  end
end
