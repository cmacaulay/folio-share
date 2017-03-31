CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:               'AWS',
    aws_access_key_id:      ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key:  ENV['AWS_SECRET_ACCESS_KEY'],
    region:                 ENV['AWS_REGION'],
    s3_host_name:           "s3-#{ENV['AWS_REGION']}.amazonaws.com"
  }

  # For testing, upload files to local `tmp` folder.
  if Rails.env.test? || Rails.env.cucumber?
    config.storage           = :file
    config.enable_processing = false
    config.root              = "#{Rails.root}/tmp"
  else
    config.storage = :fog
  end

  config.cache_dir        = "#{Rails.root}/tmp/uploads" # To let CarrierWave work on Heroku
  config.fog_directory    = ENV['S3_BUCKET_NAME']
end