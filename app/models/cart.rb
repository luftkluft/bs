class Cart < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :deliveries, as: :deliveryable
  belongs_to :user
end
