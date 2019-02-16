ActiveAdmin.register Order do
  permit_params :user_id, :item_id, :created_at, :order_total_price,
                :item_total_price, :delivery_id, :state, :addresses, :coupon

  index do
    selectable_column
    id_column
    column :user_id
    #  column :item_id
    column :created_at
    column :invoice
    # column :item_total_price
    # column :coupon
    # column :order_total_price
    # column :delivery_id
    # column :state
    # column :addresses
    # column 'address_type' do |order|
    #   Address.where(order_id: order.id).map(&:address_type)
    # end
    actions
  end

  filter :user_id
  # filter :item_id

  form do |f|
    f.inputs do
      f.input :user_id
      # f.input :item_id
      # f.input :delivery_id
    end
    f.actions
  end
end
