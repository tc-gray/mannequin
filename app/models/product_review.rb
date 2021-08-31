class ProductReview < ApplicationRecord
  belongs_to :product
  validates :content, presence: true, length: { in: 10..150 }
  validates :rating, presence: true
end
