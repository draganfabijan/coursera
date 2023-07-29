# Create Verticals
puts 'Creating Verticals'
verticals = ['Health & Fitness', 'Business', 'Music'].map do |name|
  Vertical.find_or_create_by!(name: name)
end
puts 'Verticals created'

puts 'Creating Categories'
# Define categories
category_data = [
  {name: 'Booty & Abs', vertical: verticals[0], state: 'active'},
  {name: 'Full Body', vertical: verticals[0], state: 'active'},
  {name: 'Advertising', vertical: verticals[1], state: 'active'},
  {name: 'Writing', vertical: verticals[1], state: 'active'},
  {name: 'Singing', vertical: verticals[2], state: 'active'},
  {name: 'Music Fundamentals', vertical: verticals[2], state: 'active'}
]

# Create categories and save them in an array
categories = category_data.map do |category_attrs|
  Category.find_or_initialize_by(name: category_attrs[:name], vertical: category_attrs[:vertical]).tap do |category|
    category.assign_attributes(category_attrs)
    category.save!
  end
end
puts 'Categories created'

puts 'Creating Courses'
# Define courses
courses = [
  {
    name: "Loose the Gutt, keep the Butt",
    author: "Anowa",
    category: categories[0],
    state: "active"
  },
  {
    name: "BrittneBabe Fitness Transformation",
    author: "Brittnebabe",
    category: categories[0],
    state: "active"
  },
  {
    name: "BTX: Body Transformation Extreme",
    author: "Barstarzz",
    category: categories[1],
    state: "active"
  },
  {
    name: "Facebook Funnel Marketing",
    author: "Russell Brunson",
    category: categories[2],
    state: "active"
  },
  {
    name: "Build a Wild Audience",
    author: "Tim Nilson",
    category: categories[2],
    state: "active"
  },
  {
    name: "Editorial Writing Secrets",
    author: "J. K. Rowling",
    category: categories[3],
    state: "active"
  },
  {
    name: "Scientific Writing",
    author: "Stephen Hawking",
    category: categories[3],
    state: "active"
  },
  {
    name: "Vocal Training 101",
    author: "Linkin Park",
    category: categories[4],
    state: "active"
  },
  {
    name: "Music Production",
    author: "Lady Gaga",
    category: categories[4],
    state: "active"
  },
  {
    name: "Learn the Piano",
    author: "Lang Lang",
    category: categories[5],
    state: "active"
  },
  {
    name: "Become a guitar hero",
    author: "Jimmy Page",
    category: categories[5],
    state: "active"
  }
]

# Create courses
courses.each do |course_attrs|
  Course.find_or_create_by!(course_attrs)
end
puts 'Courses created'

puts 'Finished seeding!'
