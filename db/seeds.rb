# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'securerandom'
random_string = SecureRandom.hex[0..8]

user = User.new(email: 'admin@prontoprop.com', password: random_string, role: 'Admin')
user.skip_confirmation!
user.save

