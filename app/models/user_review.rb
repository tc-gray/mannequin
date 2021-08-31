class UserReview < ApplicationRecord
  belongs_to :user
  # belongs to recipient, but is looking for user
  # can do userreview.user to get user who made review
  # and can do userreview.recipient to get the user receiving review
  # can use .recipient to get and set
  # regarding user reviews, the review belongs to the user who made the review
  belongs_to :recipient, class_name: 'User'
end
