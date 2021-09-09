class Booking < ApplicationRecord
  belongs_to :product
  belongs_to :owner, class_name: "User"
  belongs_to :user
  has_many :orders, dependent: :destroy
  has_many :deliveries, dependent: :destroy
  validates :start_date, :end_date, presence: true
  validate :start_not_end_date
  validate :overlap
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def start_not_end_date
    # this checks whether a user has inputted an end date before the start date
    # does work
    if start_date.present? && end_date.present? && start_date > end_date
      errors.add(:end_date, "cannot be before start date")
    end
  end

  def overlap
    bookings = Booking.where(product_id: product_id).where.not(id: id)
    bookings.each do |booking|
      if start_date < booking.end_date && booking.start_date < end_date
        errors.add(:base, "Oh no! This date is already booked")
        return false
      end
    end
    return true
  end
end
