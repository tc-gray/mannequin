# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require 'open-uri'

puts "Cleaning database"

Booking.destroy_all
User.destroy_all
Product.destroy_all

puts "Database cleaned"

def attach_photo(user)
  url = "https://source.unsplash.com/random?sig=#{rand(1..60)}/&portrait/300x300"
  file = URI.open(url)
  user.photo.attach(io: file, filename: "#{user.first_name.gsub(" ", "-")}.jpeg", content_type: 'image/jpeg')
end

user_1 = User.create(username:'Johnnyfash', email: 'john@gmail.com', first_name: 'John', last_name: 'Smith', password: '123456')
attach_photo(user_1)

user_2 = User.create(username:'Sallyfash', email: 'sally@gmail.com', first_name: 'Sally', last_name: 'Moon', password: '123456')
attach_photo(user_2)

puts "User created"

SIZES = ['6', '8', '10', '12', '14', '16', '18']
CATEGORY = ['Tops', 'Bottoms', 'Underwear', 'Outerwear', 'Shoes']
PRICES = [2.50, 4.50, 9.50, 7.50, 20, 10, 2.99]

20.times do
  product = Product.create!(
    name: Faker::Commerce.product_name,
    description: Faker::Hipster.sentence,
    category: CATEGORY.sample,
    size: SIZES.sample,
    price: PRICES.sample,
    user_id: User.first.id
  )
  2.times do
    url = "https://source.unsplash.com/random?sig=#{rand(1..60)}/&clothes/800x600"
    file = URI.open(url)
    product.photos.attach(io: file, filename: "#{product.name.gsub(" ", "-")}.jpeg", content_type: 'image/jpeg')
  end
end
#  product = Product.create!(name: 'Vintage Jeans', description: 'Really nice', category: 'Tops', size:'8', user_id: User.first.id)

puts "#{Product.count} products created"
