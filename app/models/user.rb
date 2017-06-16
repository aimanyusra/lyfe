class User < ApplicationRecord
  include Clearance::User

  has_many :event_users
  has_many :events, through: :event_users

  has_many :authentications, dependent: :destroy

  def self.create_with_auth_and_hash(authentication, auth_hash)
		user = User.create!(first_name: auth_hash[:extra]["raw_info"].first_name, 
			last_name: auth_hash[:extra]["raw_info"].last_name, 
			email: auth_hash["extra"]["raw_info"]["email"], 
			age: auth_hash[:extra]["raw_info"]["age_range"].min[1], 
			gender: auth_hash[:extra]["raw_info"].gender)
    user.authentications << authentication
    return user
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
