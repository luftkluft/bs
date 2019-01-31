class Review < ApplicationRecord
  include AASM
  belongs_to :book
  belongs_to :user

  validates :score,           numericality: { only_integer: true,
                                              greater_than_or_equal_to: 1,
                                              less_than_or_equal_to: 5 }
  validates :body,            presence: true,
                              length: { in: 5..1000 }

  # validates :reviewer_name,   presence: true
  # validates :state,           presence: true

  aasm column: 'state' do
    state :not_approved, initial: true
    state :approved

    event :approve do
      transitions from: :not_approved, to: :approved
    end
  end

  # def left_by_verified_reviewer?
  #   user.bought_book?(book)
  # end
end
