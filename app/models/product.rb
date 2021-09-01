class Product < ApplicationRecord
  belongs_to :user
  has_many :product_reviews
  has_many :bookings, dependent: :destroy
  has_many_attached :photos

  validates :name, presence: true
  validates :description, presence: true
  validates :category, presence: true
  validates :size, presence: true

  SIZES = ['6', '8', '10', '12', '14', '16', '18']
  CATEGORY = ['Tops', 'Bottoms', 'Underwear', 'Outerwear', 'Shoes']
end
