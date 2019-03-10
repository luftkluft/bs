class Category < ApplicationRecord
  has_many :books
  validates :type_of, presence: true, uniqueness: true, length: { maximum: 50 }
end
