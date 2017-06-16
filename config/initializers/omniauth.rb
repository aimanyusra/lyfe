Rails.application.config.middleware.use OmniAuth::Builder do
	provider :facebook, ENV["FACEBOOK_APP_KEY"], ENV["FACEBOOK_APP_SECRET"], scope: 'public_profile', info_fields: 'email, first_name, last_name, age_range, gender'
end

 
