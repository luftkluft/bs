class Review < ApplicationRecord
  include AASM
  belongs_to :book
  belongs_to :user

  validates :score,           numericality: { only_integer: true,
                                              greater_than_or_equal_to: 1,
                                              less_than_or_equal_to: 5 }
  validates :body,            presence: true,
                              length: { in: 1..500 }
  aasm column: 'state' do
    state :not_approved, initial: true
    state :approved
  end
end
