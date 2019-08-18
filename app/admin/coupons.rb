ActiveAdmin.register Coupon do
  permit_params :code, :percent, :value, :created_at

  index do
    selectable_column
    id_column
    column :code
    column :percent
    column :value
    column :created_at
    actions
  end

  filter :code

  form do |f|
    f.inputs do
      f.input :code
      f.input :percent
      f.input :value
    end
    f.actions
  end
end
