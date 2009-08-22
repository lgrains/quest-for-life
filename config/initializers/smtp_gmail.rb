require "settingslogic"
require "smtp_tls"

mailer_config = File.open("#{RAILS_ROOT}/config/mailer.yml")
mailer_options = YAML.load(mailer_config)
mailer_options[:user_name] = $private_settings.mail_user
mailer_options[:password] = $private_settings.mail_password

ActionMailer::Base.smtp_settings = mailer_options

