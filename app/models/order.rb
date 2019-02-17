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

    # event(:confirm) { transitions from: :not_confirmed, to: :waiting_for_processing }
    # event(:in_progress) { transitions from: :waiting_for_processing, to: :in_progress }
    # event(:in_delivery) { transitions from: :in_progress, to: :in_delivery }
    # event(:delivered) { transitions from: :in_delivery, to: :delivered }
  end
end
