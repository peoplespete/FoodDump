Yummly.configure do |config|
  config.app_id = Figaro.env.yummly_app_id
  config.app_key = Figaro.env.yummly_key
  config.use_ssl = true # Default is false
end


