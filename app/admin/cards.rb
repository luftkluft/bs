ActiveAdmin.register Card do
  permit_params :user_id, :created_at, :card_number, :name,
                :cvv, :expiration_month_year

  index do
    selectable_column
    id_column
    column :user_id
    column :created_at
    column :card_number
    column :name
    column :cvv
    column :expiration_month_year
    actions
  end

  filter :user_id

  form do |f|
    f.inputs do
      f.input :user_id
      f.input :card_number
      f.input :cvv
      f.input :expiration_month_year
    end
    f.actions
  end
end