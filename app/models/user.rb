class User < ApplicationRecord
  include Clearance::User

  mount_uploader :avatar, AvatarUploader

  has_many :event_users, dependent: :destroy
  has_many :events, through: :event_users, dependent: :destroy

  has_many :authentications, dependent: :destroy
  has_many :favorites, dependent: :destroy


  def self.create_with_auth_and_hash(authentication, auth_hash)
  	if auth_hash.provider == 'facebook'
			user = User.create!(
				first_name: auth_hash[:extra]["raw_info"].first_name, 
				last_name: auth_hash[:extra]["raw_info"].last_name, 
				email: auth_hash["extra"]["raw_info"]["email"], 
				age: auth_hash[:extra]["raw_info"]["age_range"].min[1], 
				gender: auth_hash[:extra]["raw_info"].gender,
				remote_avatar_url: auth_hash.info.image)
	    user.authentications << authentication
	  else
			user = User.create!(
				first_name: auth_hash.info.first_name, 
				last_name: auth_hash.info.last_name, 
				email: auth_hash.info.email, 
				gender: auth_hash.extra.raw_info.gender,
				remote_avatar_url: auth_hash.info.image)
	    user.authentications << authentication
	  end	
	  return user   	
  end

  def full_name
		"#{self.first_name} #{self.last_name}"
	end

  # grab fb_token to access Facebook for user data
  def fb_token
    x = self.authentications.find_by(provider: 'facebook')
    return x.token unless x.nil?
  end

  def password_optional?
    true
  end
end
