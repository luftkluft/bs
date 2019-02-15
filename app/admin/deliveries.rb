ActiveAdmin.register Delivery do
  permit_params :method, :duration, :price, :deliveryable_id

  index do
    selectable_column
    id_column
    column :deliveryable_id
    column :method
    column :duration
    column :price
    actions
  end

  filter :method
  filter :duration
  filter :price

  form do |f|
    f.inputs do
      f.input :method
      f.input :duration
      f.input :price
    end
    f.actions
  end
end