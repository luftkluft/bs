class Address < ApplicationRecord
  REGULAR_EXPESSION = {
    name: /\A[a-zA-Z]+\z/,
    address: /\A[a-zA-Z0-9\s,-]+\z/,
    zip: /\A[0-9-]+\z/,
    phone: /\A\+\d{3,15}\z/
  }.freeze
  belongs_to :addressable, polymorphic: true, optional: true

  validates :first_name, :last_name, :city, :country,
            format: { with: REGULAR_EXPESSION[:name] },
            length: { maximum: 50 }

  validates :address,
            format: { with: REGULAR_EXPESSION[:address] },
            length: { maximum: 50 }

  validates :zip,
            format: { with: REGULAR_EXPESSION[:zip] },
            length: { maximum: 10 }

  validates :phone,
            format: { with: REGULAR_EXPESSION[:phone] },
            length: { maximum: 15 }
end
