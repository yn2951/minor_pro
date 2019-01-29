if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['S3_access_key'],
      aws_secret_access_key: ENV['S3_access_secret'],
      region: 'ap-northeast-1'
    }

    config.fog_directory  = 'minor-pro'
    config.cache_storage = :fog
  end
end
