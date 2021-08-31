class Product < ApplicationRecord
  belongs_to :user
  has_many :product_reviews
  has_many :bookings, dependent: :destroy
  validates :name, presence: true
  validates :description, presence: true, length: { in: 10..150 }
  validates :category, presence: true
  validates :size, presence: true
end
