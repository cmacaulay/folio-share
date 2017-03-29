class Seed

  def self.start
    seed = Seed.new
    seed.generate_users
    seed.generate_folders
    seed.generate_files
    seed.generate_comments
    seed.create_admin
  end
  
  def generate_users
    1000.times do |i|
      user = User.create!(
            first_name: Faker::Name.first_name,
            last_name: Faker::Name.last_name,
            email: Faker::Internet.email,
            password: "password",
            cellphone: Faker::PhoneNumber.cell_phone
      )
      puts "User #{i}: #{user.first_name} created!"
    end
  end

  def generate_folders
    1000.times do |i|
      user = User.find(Random.new.rand(1..1000))
      folder = user.folders.create!(
        name: user.first_name
      )
      puts " Folder #{i}: Folder for #{folder.name} created!" 
    end
  end

  def generate_files
    3000.times do |i|
      folder = Folder.find(Random.new.rand(1..1000))
      upload = folder.uploads.create!(
        name: Faker::File.name,
      )
      puts "File #{i}: #{upload.name} created!"
    end
  end

  def generate_comments
    10000.times do |i|
      user = User.find(Random.new.rand(1..1000))      
      upload = Upload.find(Random.new.rand(1..3000))      
      comment = user.comments.create!(
        upload_id: upload.id,
        content: Faker::Lorem.paragraph
      )
      puts "Comment #{i} created!"
    end
  end

  def create_admin
    admin = User.create!(
      email: "admin@admin.com",
      password: "password",
      first_name: "admin",
      last_name: "admin",
      cellphone: "3333333333",
    )
  end
end

Seed.start