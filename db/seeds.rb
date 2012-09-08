# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Platform.create({ color_code: '#55ff55', name: 'Xbox 360' })
Platform.create({ color_code: '#888888', name: 'PC' })
Platform.create({ color_code: '#ffffff', name: 'Wii' })
Platform.create({ color_code: '#3333dd', name: 'PS3' })