class Coupon < ApplicationRecord
  validates :code, length: { maximum: 50 }, allow_blank: true
  validates :percent, numericality: { greater_than_or_equal_to: 0.0 }
  validates :value, numericality: { greater_than_or_equal_to: 0.0 }
end
