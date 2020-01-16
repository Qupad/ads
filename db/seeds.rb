# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# AdminUser.create!(email: 'admin@aa.a', password: 'password', password_confirmation: 'password') if Rails.env.development?
#
require 'ffaker'
require 'faker'

#AdminUser.create!(email: 'admin@a.a', password: 'password', password_confirmation: 'password') if Rails.env.development?

first = User.create(email: '1@1.1', password: '111111')
second = User.create(email: '2@2.2', password: '111111')
buy = Category.create(name: 'Buying', description: 'To buy something')
sell = Category.create(name: 'Selling', description: 'To sell something u dont want')
hire = Category.create(name: 'Hiring', description: 'To do work that u dont want to do')

10.times do 
	Article.create(title: 'Buy ' + FFaker::AnimalUS.common_name, text: Faker::Lorem.sentence, user: first, category: buy)
	Article.create(title: 'Sell ' + FFaker::AnimalUS.common_name, text: Faker::Lorem.sentence, user: first, category: sell)
	Article.create(title: 'Hire ' + Faker::Company.profession, text: Faker::Lorem.sentence, user: first, category: hire)
end