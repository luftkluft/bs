class Category < ApplicationRecord
  has_many :books
  validates :category_type, presence: true, uniqueness: true, length: { maximum: 50 }
end
