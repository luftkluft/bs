ActiveAdmin.register Address do
  permit_params :address_type, :first_name, :last_name, :address,
                :city, :zip, :country, :phone, :user_id
end
