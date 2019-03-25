class CheckoutState
  include AASM
  aasm column: 'state' do
    state :checkout_address, initial: true
    state :checkout_delivery
    state :checkout_payment
    state :checkout_confirm
    state :checkout_complete

    event :to_delyvery do
      transitions from: :checkout_address, to: :checkout_delivery
    end
  end
end