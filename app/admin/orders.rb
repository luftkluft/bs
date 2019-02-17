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
    column :delivery_id
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
  # filter :item_id

  form do |f|
    f.inputs do
      f.input :user_id
      # f.input :state
      f.input :state#,  as: :select, collection: :state
      f.input :state, as: :select, collection: [ 'not_confirmed',
                                                 'waiting_for_processing',
                                                 'in_progress',
                                                 'in_delivery',
                                                 'delivered']
      # dropdown_menu "State" do
      #   item :not_confirmed
      #   item :waiting_for_processing,
      #   item :in_progress
      #   item :in_delivery
      #   item :delivered
      #   item "Edit Details"#, edit_details_path
      #   item "Edit My Account"#, edit_my_acccount_path
      # end
    end
    f.actions
  end
end
