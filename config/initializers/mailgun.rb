Mailgun.configure do |config|
  config.api_key = ENV['MAILGUN_SECRET_KEY']
end