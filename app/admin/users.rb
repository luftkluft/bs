ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :role, :name, :addresses

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column :role
    column :addresses
    column 'address_type' do |user|
      Address.where(user_id: user.id).map(&:address_type)
    end
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :role
      f.input :addresses
    end
    f.actions
  end
end
