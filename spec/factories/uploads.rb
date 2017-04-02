FactoryGirl.define do
  factory :upload do
    attachment { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec", "support", "fixtures", "attachments", "femalecodercat.jpg"), "image/jpg") }
    content_type "image/jpg"
    size 56434
    name "femalecodercat.jpg"
    folder
    attachment "/spec/fixtures/elephant.jpg"
  end
end
