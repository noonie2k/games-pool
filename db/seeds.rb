# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create({
  username: 'admin',
  email: 'adam.ian.noon@gmail.com',
  name: 'Administrator',
  password: 'secret',
  password_confirmation: 'secret',
  admin: true
})
