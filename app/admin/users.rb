ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :role, :name, :addresses, :order_id, :purchased_books

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column :role
    column 'Addresses' do |user|
      Address.where(user_id: user.id, order_id: 0)
    end
    column 'address_type' do |user|
      Address.where(user_id: user.id, order_id: 0).map(&:address_type)
    end
    column :purchased_books
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
