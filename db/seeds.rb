# Create Verticals
verticals = ['Health & Fitness', 'Business', 'Music'].map do |name|
  Vertical.find_or_create_by!(name: name)
end

# Define categories
categories = [
  {name: 'Booty & Abs', vertical: verticals[0], state: 'active'},
  {name: 'Full Body', vertical: verticals[0], state: 'active'},
  {name: 'Advertising', vertical: verticals[1], state: 'active'},
  {name: 'Writing', vertical: verticals[1], state: 'active'},
  {name: 'Singing', vertical: verticals[2], state: 'active'},
  {name: 'Music Fundamentals', vertical: verticals[2], state: 'active'}
]

# Create categories
categories.each do |category_attrs|
  Category.find_or_create_by!(category_attrs)
end