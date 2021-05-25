json.extract! @cocktail, :id, :name, :description
json.comments @cocktail.comments do |comment|
  json.extract! comment, :id, :content
end
