# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false

config.log_level = :debug

# Don't care if the mailer can't send
config.action_mailer.raise_delivery_errors = false

APP_URL = "http://localhost:3000" #(or whatever your URL will be for that particular environment)

config.after_initialize do
  ActiveMerchant::Billing::Base.mode = :test
  paypal_options = {
    :login => "jobs_1306083288_biz_api1.hotmail.com",
    :password => "1306083303",
    :signature => "AAJkn7aEBhVSuG1c6B1m-p7s9jveAAwBp3aq2SGXJmN8jD27u74xmUng"
  }
  ::STANDARD_GATEWAY = ActiveMerchant::Billing::PaypalGateway.new(paypal_options)
  ::EXPRESS_GATEWAY = ActiveMerchant::Billing::PaypalExpressGateway.new(paypal_options)
end

#ActionMailer::Base.delivery_method = :smtp
#ActionMailer::Base.smtp_settings = {
# :address => "smtp.sendgrid.net",
# :port => 25,
# :domain => "marketfu.com",
# :authentication => :plain,
# :user_name => "w.flanagan@tempusgroup.com",
# :password => "password"
#}

config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => 'gmail.com',
  :user_name            => 'dummy@41studio.com',
  :password             => 'ssstsecret',
  :authentication       => 'plain',
  :enable_starttls_auto => true  }