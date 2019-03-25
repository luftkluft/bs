ActiveAdmin.register Order do
  permit_params :user_id, :item_id, :created_at, :order_total_price,
                :item_total_price, :delivery_id, :state, :addresses, :coupon

  index do
    selectable_column
    id_column
    column :user_id
    column :created_at
    column :invoice
    column :item_total_price
    column :coupon
    column :order_total_price
    column 'Delivery' do |order|
      Delivery.find_by(id: order.delivery_id).method
    end
    column :state
    column 'Address' do |order|
      Address.where(order_id: order.id)
    end
    column 'address_type' do |order|
      Address.where(order_id: order.id).map(&:address_type)
    end
    actions
  end

  filter :user_id

  form do |f|
    f.inputs do
      f.input :user_id
      f.input :state
      f.input :state, as: :select, collection: ['not_confirmed',
                                                'waiting_for_processing',
                                                'in_progress',
                                                'in_delivery',
                                                'delivered']
    end
    f.actions
  end
end
