ActiveAdmin.register OrderItem do
  permit_params :book_id, :order_id, :quantity

  index do
    selectable_column
    id_column
    column :book_id
    column :order_id
    column :quantity
    actions
  end

  filter :book_id
  filter :order_id
  filter :quantity

  form do |f|
    f.inputs do
      f.input :book_id
      f.input :order_id
      f.input :quantity
    end
    f.actions
  end
end
