# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_quest_for_life_session',
  :secret      => 'b41a928ac13f6ec9833730bafa30f35edf6aceeb3fb9d23efedc438b3abf659a21fba72e2aae574226de2855d67342f9875f0052b64ba9f5f819ac9efafa9fb6'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
