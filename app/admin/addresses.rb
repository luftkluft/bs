ActiveAdmin.register Address do
  permit_params :address_type, :first_name, :last_name, :address,
                :city, :zip, :country, :phone, :user_id, :order_id

  index do
    selectable_column
    id_column
    column :user_id
    column :first_name
    column :last_name
    column :address_type
    column :address
    column :city
    column :zip
    column :country
    column :phone
    column :order_id
    actions
  end

  filter :user_id
  filter :address_type

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :address
      f.input :city
      f.input :zip
      f.input :country
      f.input :phone
    end
    f.actions
  end
end
