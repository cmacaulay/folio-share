class Seed
    UserRole.destroy_all
    Role.destroy_all
    Comment.destroy_all
    User.destroy_all
    Upload.destroy_all
    Folder.destroy_all

  def self.start
    seed = Seed.new
    seed.create_roles
    seed.generate_users
    seed.generate_uploads
    seed.generate_comments
    seed.create_admin
  end

  def create_roles
    Role.create(name: "registered user")
    Role.create(name: "admin")
    puts "Roles Created"
  end

  def create_admin
    admin = User.create!(username: "administrator",
            first_name: "administrator",
            last_name: "administrator",
            email:"admin@admin.com",
            password: "password",
            reset_token:"",
            cellphone:"3333333333",
            token:"")
    admin.roles.create(name:"admin")
    puts "Admin Created"
  end

  def generate_users
    10.times do |i|
      user = User.create!(
            first_name: Faker::Name.first_name,
            last_name: Faker::Name.last_name,
            username: Faker::Name.unique.name,
            email: Faker::Internet.email,
            password: "password",
            cellphone: Faker::PhoneNumber.cell_phone
      )
      puts "User #{i}: #{user.first_name} created!"
    end
  end

  def generate_uploads
    100.times do |i|
      folder = Folder.order("RANDOM()").first
      upload = folder.uploads.create!(
              name: Faker::Name.name,
              content_type: Faker::File.mime_type,
              size: Faker::Number.number(4)
      )
      puts "File #{i}: #{upload.name} created!"
    end
  end

  def generate_comments
    300.times do |i|
      user = User.order("RANDOM()").first
      upload = Upload.order("RANDOM()").first
      comment = user.comments.create!(
              upload_id: upload.id,
              content: Faker::StarWars.quote
      )
      puts "Comment #{i} created!"
    end
  end
end
Seed.start
