class Product < ApplicationRecord
  belongs_to :user
  has_many :product_reviews
  has_many :bookings, dependent: :destroy
end
