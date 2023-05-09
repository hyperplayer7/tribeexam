# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Bundle.create(code: 'IMG', quantity: 5, price: 450.00)
Bundle.create(code: 'IMG', quantity: 10, price: 800.00)
Bundle.create(code: 'Flac', quantity: 3, price: 427.50)
Bundle.create(code: 'Flac', quantity: 6, price: 810.00)
Bundle.create(code: 'Flac', quantity: 9, price: 1147.50)
Bundle.create(code: 'VID', quantity: 3, price: 570.00)
Bundle.create(code: 'VID', quantity: 5, price: 900.00)
Bundle.create(code: 'VID', quantity: 9, price: 1530.00)