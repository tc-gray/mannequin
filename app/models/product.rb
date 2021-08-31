class Product < ApplicationRecord
  belongs_to :user
  has_many :product_reviews
  has_many :bookings, dependent: :destroy
  validates :name, presence: true
  validates :description, presence: true
  validates :category, presence: true
  validates :size, presence: true
end
