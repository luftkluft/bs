ActiveAdmin.register Cart do
  permit_params :user_id, :created_at, :order_total_price, :coupon

  index do
    selectable_column
    id_column
    column :user_id
    column :created_at
    column 'Items' do |cart|
      Book.where(id: cart.items.map(&:book_id)) # .map(&:title)
    end
    column 'Quantity' do |cart|
      cart.items.map(&:quantity)
    end
    column :item_total_price
    column :coupon
    column :order_total_price
    actions
  end

  filter :user_id

  form do |f|
    f.inputs do
      f.input :user_id
      f.input :coupon
      f.input :order_total_price
    end
    f.actions
  end
end
