class User < ApplicationRecord
  has_many :bookings
  has_many :user_reviews
  has_many :products, dependent: :destroy
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
