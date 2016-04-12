include RandomData

50.times do
  User.create!(
    email: RandomData.random_email,
    password: "mystring",
    password_confirmation: "mystring",
    confirmed_at: Date.today,
    name: Faker::Name.name
  )
end

users = User.all

100.times do
  Wiki.create!(
    user: users.sample,
    title: Faker::Book.title,
    body: Faker::Lorem.paragraphs
  )
end

User.create!(
  email: "luiscamacho@gmail.com",
  password: "12345678",
  password_confirmation:  "12345678",
  confirmed_at: Date.today,
  name: "Luis Gmail",
  role: 'admin'
)

User.create!(
  email: "camacho@knightfoundation.org",
  password: "12345678",
  password_confirmation:  "12345678",
  confirmed_at: Date.today,
  name: "Luis Exchange",
  role: 'admin'
)

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
