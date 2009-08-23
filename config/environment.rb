# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.3' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|

  config.gem 'haml'
  config.gem 'binarylogic-settingslogic', :lib => 'settingslogic', :source => 'http://gems.github.com'
  config.gem 'justinfrench-formtastic', :lib => 'formtastic', :source => 'http://gems.github.com'
  config.gem 'thoughtbot-clearance', :lib => 'clearance', :source => 'http://gems.github.com'
  config.gem 'mislav-will_paginate', :lib => 'will_paginate', :source => 'http://gems.github.com'
  config.gem 'ruby-openid', :lib => 'openid'
  config.gem 'chriseppstein-compass', :version => '0.8.10', :lib => 'compass', :source => 'http://gems.github.com'
  config.gem 'jcnetdev-better_partials', :version => '>= 1.1', :lib => 'better_partials', :source => 'http://gems.github.com'
  config.gem 'binarylogic-searchlogic', :version => '2.2.3', :lib => 'searchlogic', :source => 'http://gems.github.com'


  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  config.frameworks -= [ :active_resource ]

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'UTC'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de
end
