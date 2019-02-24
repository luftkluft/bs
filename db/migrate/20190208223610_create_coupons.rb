class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|
      t.string :code
      t.decimal :percent, default: 0.0
      t.decimal :value, precision: 8, scale: 2, default: 0.0

      t.timestamps
    end
  end
end
