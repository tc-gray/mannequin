class Booking < ApplicationRecord
  belongs_to :product
  belongs_to :owner, class_name: "User"
  belongs_to :user
  has_many :orders, dependent: :destroy
  validates :start_date, :end_date, presence: true
  validate :start_not_end_date
  validate :overlap
  # before_create :overlap

  def start_not_end_date
    # this checks whether a user has inputted an end date before the start date
    # does work
    if start_date.present? && end_date.present? && start_date > end_date
      errors.add(:end_date, "cannot be before start date")
    end
  end

  def overlap
    # not working as of yet, this is to handle bookings where dates are overlapping
    # so if a user books for a certain period and another user books the same item
    # for the same period or overlapping
    # it should flag an error

    bookings = Booking.where(product_id: product_id)
    bookings.each do |booking|
      if start_date < booking.end_date && booking.start_date < end_date
        errors.add(:base, "Oh no! This date is already booked")
      end
    end


    # bookings = Booking.where('start_date < ? OR end_date > ?', self.start_date, self.end_date)
    # return bookings.empty?
  end
end
