Rails.application.config.middleware.use OmniAuth::Builder do
	# scraping data from FB to get user details for creation
	provider :facebook, ENV["FACEBOOK_APP_KEY"], ENV["FACEBOOK_APP_SECRET"], scope: 'public_profile', info_fields: 'email, first_name, last_name, age_range, gender'
	provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']
end

 
