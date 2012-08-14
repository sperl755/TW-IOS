# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_CommunityEngine_session',
  :secret      => '69c6e4e5945af4d405ae13bf449e3e57c2e50795db4ae8c499e56be2aa90352fd3d25f7febd65e5139b05cde47c3f86c2f2239b9a37bb535a0fab2095695b38a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
