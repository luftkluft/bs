class Card < ApplicationRecord
  belongs_to :user
  REGULAR_EXPESSION = {
    card_number: /\A[0-9]{4}\s[0-9]{4}\s[0-9]{4}\s[0-9]{4}\z/,
    name: /\A[a-zA-Z]+\z/,
    # expiration_month_year: /\A(0[1-9]|1[0-2])[/][1][0-9]\z/#,
    cvv: /\A\d{3,4}\z/
  }.freeze

  validates :card_number,
            format: { with: REGULAR_EXPESSION[:card_number] },
            length: { maximum: 19 }

  validates :name,
            format: { with: REGULAR_EXPESSION[:name] },
            length: { maximum: 50 }

  validates :cvv,
            format: { with: REGULAR_EXPESSION[:cvv] },
            length: { maximum: 4 }

  validates :expiration_month_year,
            format: { with: REGULAR_EXPESSION[:expiration_month_year] },
            length: { maximum: 5 }
end
