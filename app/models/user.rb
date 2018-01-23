class User < ApplicationRecord
  include Clearance::User
  has_many :authentications, dependent: :destroy
  has_many :jobs
  mount_uploader :users_avatar, VerificationDocumentsUploader


    def self.create_with_auth_and_hash(authentication, auth_hash)
      if auth_hash.provider == 'google_oauth2'
        user = self.create!(
          first_name: auth_hash["info"]["first_name"],
          last_name: auth_hash["info"]["last_name"],
          email: auth_hash["info"]["email"],
          password: SecureRandom.hex(16)
        )
        user.authentications << authentication
        return user
      else auth_hash.provider == 'facebook'
        user = self.create!(
          first_name: auth_hash["extra"]["raw_info"]["first_name"],
          last_name: auth_hash["extra"]["raw_info"]["last_name"],
          email: auth_hash["extra"]["raw_info"]["email"],
          password: SecureRandom.hex(16)
        )
        user.authentications << authentication
        return user
      end  
    end

    # grab fb_token to access Facebook for user data
    def fb_token
      x = self.authentications.find_by(provider: 'facebook')
      return x.token unless x.nil?
    end
end
