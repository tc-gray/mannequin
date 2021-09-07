# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# require 'faker'
# require 'open-uri'

puts "Cleaning database"

Booking.destroy_all
User.destroy_all
# Product.destroy_all

puts "Database cleaned"

def attach_photo(user)
  url = "https://source.unsplash.com/random?sig=#{rand(1..60)}/&portrait/300x300"
  file = URI.open(url)
  user.photo.attach(io: file, filename: "#{user.first_name.gsub(" ", "-")}.jpeg", content_type: 'image/jpeg')
end

user_1 = User.create(username:'Johnnyfash', email: 'john@gmail.com', first_name: 'John', last_name: 'Smith', password: '123456')
attach_photo(user_1)

puts "user created"

user_2 = User.create(username:'Sallyfash', email: 'sally@gmail.com', first_name: 'Sally', last_name: 'Moon', password: '123456')
attach_photo(user_2)

user_3 = User.create(username:'Jessicafash', email: 'jessica@gmail.com', first_name: 'Jessica', last_name: 'Rabbit', password: '123456')
attach_photo(user_3)

user_4 = User.create(username:'Sonnyfash', email: 'sonny@gmail.com', first_name: 'Sonny', last_name: 'Jim', password: '123456')
attach_photo(user_4)

puts "Users created"

location_1 = Delivery.create(address: "36-37 Strand
London
WC2N 5HY", name: "Sainsbury's Strand")

location_2 = Delivery.create(address: "10 Rochester Row
London
SW1P 1BT", name: "Sainsbury's Rochester Row")

location_3 = Delivery.create(address: "1 Berners Street
London
W1T 3LA", name: "Sainsbury's Berners Street")

location_4 = Delivery.create(address: "15-17 Tottenham Court Road
London
W1T 1BJ
", name: "Sainsbury's TCR")

location_5 = Delivery.create(address: "101 Waterloo Road
London
SE1 8UL", name: )

# SIZES = ['6', '8', '10', '12', '14', '16', '18']
# CATEGORY = ['Tops', 'Bottoms', 'Underwear', 'Outerwear', 'Shoes']
# PRICES = [2.50, 4.50, 9.50, 7.50, 20, 10, 2.99]

# 20.times do
#   product = Product.create!(
#     name: Faker::Commerce.product_name,
#     description: Faker::Hipster.sentence,
#     category: CATEGORY.sample,
#     size: SIZES.sample,
#     price: PRICES.sample,
#     user_id: User.first.id
#   )
#   2.times do
#     url = "https://source.unsplash.com/random?sig=#{rand(1..60)}/&clothes/800x600"
#     file = URI.open(url)
#     product.photos.attach(io: file, filename: "#{product.name.gsub(" ", "-")}.jpeg", content_type: 'image/jpeg')
#   end
# end
# #  product = Product.create!(name: 'Vintage Jeans', description: 'Really nice', category: 'Tops', size:'8', user_id: User.first.id)

require 'open-uri'
require 'nokogiri'

user_array = [user_1, user_2, user_3, user_4]
search_term_array = ['dress', 'trousers', 'top', 'shoes', 'sweater']
color_array = ['red', 'pink', 'white', 'blue', 'green', 'black', 'multicolor']
sizes_array = ['6', '8', '10', '12', '14', '16', '18']

# 15.times do
#   search_term = search_term_array.sample
#   color = color_array.sample

#   url = "https://www.depop.com/search/?q=#{color}+#{search_term}"
#   html_file = URI.open(url).read
#   html_doc = Nokogiri::HTML(html_file)

#   html_doc.search('.styles__ProductCard-sc-__sc-13q41bc-2').first(10).each do |element|

#     product_url = "https://www.depop.com#{element.attribute('href').value}"
#     file = URI.open(product_url).read
#     doc = Nokogiri::HTML(file)

#     if doc.search('.dYhoOp').attribute('src')
#       # img_url = doc.search('.styles__Image-sc-__sc-1fk4zep-8').attribute('src').value.to_s
#       product = Product.create!(
#         name: "#{color.capitalize} #{search_term.capitalize}",
#         description: doc.search('.styles__DescriptionContainer-sc-__sc-1fk4zep-10')[0].text.strip,
#         category: search_term,
#         size: sizes_array.sample,
#         price: doc.search('.Pricestyles__FullPrice-sc-__sc-1vj3zjr-0').text.strip,
#         user_id: user_array.sample.id
#       )

#       img_url = doc.search('.dYhoOp').attribute('src').value.to_s
#       img_file = URI.open(img_url)
#       product.photos.attach(io: img_file, filename: "#{product.name.gsub(" ", "-")}.jpeg", content_type: 'image/jpeg')
#       puts "product created"
#     end
#   end
# end

# puts "#{Product.count} products created"
