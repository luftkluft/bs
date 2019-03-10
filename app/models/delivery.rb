class Delivery < ApplicationRecord
  belongs_to :deliveryable, polymorphic: true, optional: true
  validates :method, length: { maximum: 50 }, allow_blank: false
  validates :duration, length: { maximum: 50 }, allow_blank: false
  validates :price, numericality: { greater_than_or_equal_to: 0.0 }
end
