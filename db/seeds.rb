puts 'Creating users...'

user_1 = User.create!(name: "Meghan", email: "meghanxmartin@gmail.com", password: "123456")


puts 'Creating topics...'
Topic.create!({
  title: "Javascript",
  color: "A094FF",
  user: user_1
})
Topic.create!({
  title: "Accessibility",
  color: "#FFBFFF",
  user: user_1
})
puts 'Finished!'
