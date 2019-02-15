class Delivery < ApplicationRecord
  belongs_to :deliveryable, polymorphic: true, optional: true
end
