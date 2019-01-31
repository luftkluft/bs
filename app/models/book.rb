class Book < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :category
  has_many :reviews, dependent: :destroy
  validates :title, presence: true,
                    length: { in: 6..80 },
                    uniqueness: false

  validates :description, presence: true,
                          length: { in: 10..1000 }

  validates :author, presence: true,
                     length: { in: 2..1000 }

  # validates :image,       presence: true
  validates :materials,   presence: true
  validates :price,       numericality: { greater_than_or_equal_to: 0.1 }
  validates :height,      numericality: { greater_than_or_equal_to: 5.0 }
  validates :width,       numericality: { greater_than_or_equal_to: 3.0 }
  validates :depth,       numericality: { greater_than_or_equal_to: 0.1 }

  validates :in_stock, numericality: { greater_than_or_equal_to: 0,
                                       only_integer: true }

  validates :category_id, numericality: { greater_than_or_equal_to: 0,
                                          only_integer: true }

  validates :year, numericality: { greater_than_or_equal_to: 1990,
                                   less_than_or_equal_to: Time.now.year,
                                   only_integer: true }
end
