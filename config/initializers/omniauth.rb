Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, ENV['FACEBOOK_APP_KEY'], ENV['FACEBOOK_APP_SECRET'],
    scope: 'email,public_profile,publish_actions',
    info_fields: 'name,email,first_name,last_name'

  	provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], 
  	scope: 'profile, email', 
  	info_fields: 'name, email, first_name, last_name'
  
end