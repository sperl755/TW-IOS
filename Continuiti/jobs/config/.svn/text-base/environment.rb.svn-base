# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.12' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')
Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.
   config.plugins = [:community_engine, :white_list, :all]
   config.plugin_paths += ["#{RAILS_ROOT}/vendor/plugins/community_engine/plugins"]
	require 'desert'
   config.gem 'calendar_date_select'
   config.gem 'icalendar'        
   config.gem 'authlogic', :version => '2.1.6'
   config.gem 'searchlogic', :version => '2.4.28'
   config.gem 'google-geo', :source=> "http://gemcutter.org"
   config.gem 'sass'
   config.gem 'will_paginate', :version => '~> 2.3.5'
   config.gem 'activemerchant', :lib => 'active_merchant'
   config.gem 'ajaxful_rating'
   config.gem 'sunspot', :lib => 'sunspot'
   config.gem 'sunspot_rails', :lib => 'sunspot_rails'
   config.gem 'facebooker'
   ##########
   config.gem "json"
   config.gem 'faraday'
  config.gem 'rack-openid', :lib => 'rack/openid', :version => '>=0.2.1'
  config.gem "oauth"
  config.gem "authlogic-connect"
  config.gem "authlogic-oauth", :lib => "authlogic_oauth"
   ###############
   require 'google/geo'
	config.action_controller.session = {

	 :key    => '_your_app_session',
	 :secret => 'secret'

	}
  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Specify gems that this application depends on and have them installed with rake gems:install
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"

  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'UTC'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de
end
 require "#{RAILS_ROOT}/vendor/plugins/community_engine/config/boot.rb"
 OpenIdAuthentication.store = :file
