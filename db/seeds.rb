# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


countries = Country.create([{name: "United States of America"},{name: "India"},{name: "United Kingdom"}])

usa = Country.find_by name: "United States of America"
states = State.create([{name: "California", country_id: usa.id },{name: "New York", country_id: usa.id },{name: "Arizona", country_id: usa.id }])

arizona = State.find_by name: "Arizona"
cities = City.create([{name: "Phoenix", state_id: arizona.id},{name: "Tempe", state_id: arizona.id}, {name: "Tuscon", state_id: arizona.id}])

california = State.find_by name: "California"
cities = City.create([{name: "Los Angeles", state_id: california.id},{name: "San Francisco", state_id: california.id}])

Inventory.create(name:"Brand HD TV", description: "Brand Ultra HD 50", quantity: 500, status: 1)
Inventory.create(name:"Brand Shoes", description: "Brand Air Shoes. Ultra comfort sports shoes", quantity: 100, status: 1)
Inventory.create(name:"Brand Pen", description: "Ultra writing comfort", quantity: 2000, status: 1)
Inventory.create(name:"Brand Laptops", description: "Brand Laptop high performance", quantity: 200, status: 1)
