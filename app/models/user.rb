class User < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :bookings
  has_many :requested_bookings, through: :products, source: :bookings
  has_many :user_reviews
  has_many :chatrooms
  has_one_attached :photo
  # validates :username, presence: true, uniqueness: true
  validates :password, presence: true
  # validates :first_name, presence: true
  # validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
