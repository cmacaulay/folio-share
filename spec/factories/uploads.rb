FactoryGirl.define do
  factory :upload do
    attachment { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'fixtures', 'femalecodercat.jpg'), 'image/jpg') }
    content_type 'image/jpg'
    size 56434
    folder
  end
end
