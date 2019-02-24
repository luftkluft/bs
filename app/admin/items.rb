ActiveAdmin.register Item do
  permit_params :book_id, :cart_id, :quantity

  index do
    selectable_column
    id_column
    column :book_id
    column :cart_id
    column :quantity
    actions
  end

  filter :book_id
  filter :cart_id
  filter :quantity

  form do |f|
    f.inputs do
      f.input :book_id
      f.input :cart_id
      f.input :quantity
    end
    f.actions
  end
end
