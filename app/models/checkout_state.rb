class CheckoutState
  include AASM
  aasm column: 'state' do
    state :checkout_address, initial: true
    state :checkout_delivery
    state :checkout_payment
    state :checkout_confirm
    state :checkout_complete
  end
end