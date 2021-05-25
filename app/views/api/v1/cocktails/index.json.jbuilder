json.array! @cocktails do |cocktail|
  json.extract! cocktail, :id, :name, :description
end
