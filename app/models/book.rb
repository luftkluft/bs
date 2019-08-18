class Book < ApplicationRecord
  mount_uploader :image, ImageUploader
  mount_uploader :image_1, ImageUploader
  mount_uploader :image_2, ImageUploader
  mount_uploader :image_3, ImageUploader
  belongs_to :category
  has_many :reviews, dependent: :destroy
  has_many :items, dependent: :nullify
  has_many :order_items, dependent: :nullify
  validates :title, presence: true,
                    length: { in: 1..80 },
                    uniqueness: false

  validates :description, presence: true,
                          length: { in: 1..1000 }

  validates :author, presence: true,
                     length: { in: 1..1000 }

  validates :materials,   presence: true
  validates :price,       numericality: { greater_than_or_equal_to: 0.01 }
  validates :height,      numericality: { greater_than_or_equal_to: 1.0 }
  validates :width,       numericality: { greater_than_or_equal_to: 1.0 }
  validates :depth,       numericality: { greater_than_or_equal_to: 0.1 }

  validates :in_stock, numericality: { greater_than_or_equal_to: 0,
                                       only_integer: true }

  validates :category_id, numericality: { greater_than_or_equal_to: 0,
                                          only_integer: true }

  validates :year, numericality: { greater_than_or_equal_to: 1800,
                                   less_than_or_equal_to: Time.zone.now.year,
                                   only_integer: true }

  validates :popularity, numericality: { greater_than_or_equal_to: 0,
                                         only_integer: true }
end
