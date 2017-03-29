# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do
  first = Faker::Name.first_name
  last = Faker::Name.last_name
  User.create(
    first_name: first,
    last_name: last,
    cellphone: Faker::PhoneNumber.phone_number,
    email: Faker::Internet.safe_email("#{first}.#{last}"),
    password: "password"
  )
end

binding.pry

User.all.each do |user|
  rand(0..5).times do
    user.folders.create(
      name: "Folder #{Faker::Lorem.word}",
      parent_id: user.folders.sample
    )
  end
  user.folders.each do |folder|
    rand(0..5).times do
      folder.uploads.create(
        name: "File #{Faker::Lorem.word}",
        content_type: Faker::File.mime_type,
        size: rand(1..10000)
      )
    end
  end
end
