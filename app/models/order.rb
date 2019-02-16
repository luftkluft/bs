class Order < ApplicationRecord
  has_many :addresses, as: :addressable
  has_many :order_items, dependent: :destroy
end
