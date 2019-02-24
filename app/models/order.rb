class Order < ApplicationRecord
  include AASM
  has_many :addresses, as: :addressable
  has_many :order_items, dependent: :destroy

  aasm column: 'state' do
    state :not_confirmed, initial: true
    state :waiting_for_processing
    state :in_progress
    state :in_delivery
    state :delivered
  end
end
