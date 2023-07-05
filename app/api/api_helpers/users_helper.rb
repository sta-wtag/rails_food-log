

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
    end
end
