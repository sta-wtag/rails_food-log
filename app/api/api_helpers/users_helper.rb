

module ApiHelpers
    module UsersHelper    
        def generate_refresh_token
          loop do
            # generate a random token string and return it, 
            # unless there is already another token with the same string
            token = SecureRandom.hex(32)
            break token unless Doorkeeper::AccessToken.exists?(refresh_token: token)
          end
        end 
        def current_user
          if doorkeeper_token.present?
              @current_user ||= User.find_by(id: doorkeeper_token[:resource_owner_id])
          else
              @current_user = User.find_by(id:1)
          end
        end 
    end
end
