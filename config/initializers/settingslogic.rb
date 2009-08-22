
private_file = "#{RAILS_ROOT}/config/#{RAILS_ENV}_settings.yml"
$private_settings = Settings.new(private_file) if File.exists?(private_file)

