class CheckoutState < ApplicationRecord
  include AASM
  aasm column: 'state' do
    state :checkout_address, initial: true
    state :checkout_delivery
    state :checkout_payment
    state :checkout_confirm
    state :checkout_complete
  end

  # commented code causes an error when starting the server
  # /home/user/.rvm/gems/ruby-2.5.3@bs/gems/activerecord-5.2.2/lib/active_record/dynamic_matchers.rb:22:in
  # `method_missing': undefined method `event' for #<Class:0x000055e993ad5d90> (NoMethodError)

  # event :to_delyvery do
  #   transitions from: :checkout_address, to: :checkout_delivery
  # end
end