# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_skeletor_session',
  :secret      => '825331b2a5c32bc9c5469107046e53318744e1f8a4e7cb69e84effea281ea2cc02e073333c04fbe6956c414da67ef25af08f08e3221042b89eb5b425f9c179e3'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
