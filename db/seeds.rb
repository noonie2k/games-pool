# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Platform.create({ color_code: '#5c5', name: 'Xbox 360' })
Platform.create({ color_code: '#888', name: 'PC' })
Platform.create({ color_code: '#fff', name: 'Wii' })
Platform.create({ color_code: '#33d', name: 'PS3' })