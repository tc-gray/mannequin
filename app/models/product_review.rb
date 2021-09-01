class ProductReview < ApplicationRecord
  belongs_to :product
  belongs_to :user
  validates :content, presence: true, length: { in: 10..150 }
  validates :rating, presence: true, inclusion: { in: 0..5 }, numericality: { only_integer: true }
end
