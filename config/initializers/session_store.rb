# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_upgrade-error-demo_session',
  :secret      => '079ec3c85920a9e052032eae491e83ec996283ed664844b5654d79c6fed80bd10d2f34c338eaa0c0dc9d473f79d21c904d551b90381262eaa3859518e020b09d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
