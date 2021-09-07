class Booking < ApplicationRecord
  belongs_to :product
  belongs_to :user
  has_many :orders, dependent: :destroy
  validates :start_date, :end_date, presence: true
end
