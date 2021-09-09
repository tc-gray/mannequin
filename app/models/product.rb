class Product < ApplicationRecord
  belongs_to :user
  has_many :product_reviews, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :chatrooms, dependent: :destroy
  has_many_attached :photos

  validates :name, presence: true
  validates :description, presence: true
  validates :category, presence: true
  validates :size, :price, presence: true

  SIZES = ['6', '8', '10', '12', '14', '16', '18', '20']
  CATEGORYS = ['dress', 'trouser', 'top', 'shoes', 'jumpsuit', 'sweater', 'jeans', 'jacket', 'accessories']
  COLOR = ['red', 'pink', 'white', 'blue', 'green', 'black', 'multicolor']
  # CATEGORY = ['Tops', 'Bottoms', 'Underwear', 'Outerwear', 'Shoes']

  include PgSearch::Model
  pg_search_scope :search_by_name_and_description_and_size_and_category,
    against: [ :name, :description, :size, :category ],
    associated_against: { user: [ :username, :first_name, :last_name ] },
    using: {
      tsearch: { prefix: true }
    }

  monetize :price_cents

  acts_as_favoritable
end
