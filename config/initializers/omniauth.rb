Rails.application.config.middleware.use OmniAuth::Builder do
  provider :instagram, ENV['INSTAGRAM_KEY'], ENV['INSTAGRAM_SECRET']
end