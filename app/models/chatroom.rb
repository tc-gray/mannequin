class Chatroom < ApplicationRecord
  has_many :messages
  # in order for the chatroom to be a 1:1 relationship, we need
  # the chatroom to belong to a product and a user
  # so we first made a migration to add a foreign key to the user and the product
  # then because a chatroom belongs to both a user and a product
  # we need additional instance variables in the controller for chatroom
  belongs_to :user
  belongs_to :product
end
