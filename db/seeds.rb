# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
puts "Cleaning database"

User.destroy_all
Product.destroy_all

puts "Database cleaned"

user_1 = User.create(username:'Johnnyfash', email: 'john@gmail.com', first_name: 'John', last_name: 'Smith', password: '123456')

user_2 = User.create(username:'Sallyfash', email: 'sally@gmail.com', first_name: 'Sally', last_name: 'Moon', password: '123456')
puts "User created"
SIZES = ['6', '8', '10', '12', '14', '16', '18']
CATEGORY = ['Tops', 'Bottoms', 'Underwear', 'Outerwear', 'Shoes']

20.times do
  Product.create!(
    name: Faker::Commerce.product_name,
    description: Faker::Hipster.sentence,
    category: CATEGORY.sample,
    size: SIZES.sample,
    user_id: User.first.id
  )
end
#  product = Product.create!(name: 'Vintage Jeans', description: 'Really nice', category: 'Tops', size:'8', user_id: User.first.id)

puts "#{Product.count} products created"
