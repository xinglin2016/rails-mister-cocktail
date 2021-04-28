# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Creating cocktails..."

Ingredient.create(name: "lemon")
Ingredient.create(name: "ice")
Ingredient.create(name: "mint leaves")


require 'json'
require 'open-uri'

puts "Starting seed"

puts "Creating cocktails..."

def cocktail_name
  url = 'https://www.thecocktaildb.com/api/json/v1/1/random.php'
  cocktail_serialized = open(url).read
  return JSON.parse(cocktail_serialized)["drinks"][0]["strDrink"]
end

def cocktail_description
  url = 'https://www.thecocktaildb.com/api/json/v1/1/random.php'
  cocktail_serialized = open(url).read
  return JSON.parse(cocktail_serialized)["drinks"][0]["strInstructions"]
end

def cocktail_picture
  url = 'https://www.thecocktaildb.com/api/json/v1/1/random.php'
  cocktail_serialized = open(url).read
  return JSON.parse(cocktail_serialized)["drinks"][0]["strDrinkThumb"]
end

def cocktail_ingredients
  url = 'https://www.thecocktaildb.com/api/json/v1/1/random.php'
  cocktail_serialized = open(url).read
  return JSON.parse(cocktail_serialized)["drinks"][0]["strIngredient1"]
end

3.times do
  cocktail = Cocktail.new(
    name: cocktail_name
    )
  cocktail.save!
  # file = URI.open(dog[0]["url"])
  # breed.photo.attach(io: file, filename: 'breed_pic.jpg', content_type: 'image/jpg')
  # breed.save!
  puts "Created cocktail #{cocktail.name}"
end
