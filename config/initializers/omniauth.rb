Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV["Twitter_API_key"], ENV["Twitter_API_secret"], secure_image_url: 'true', image_size: 'original'
end
