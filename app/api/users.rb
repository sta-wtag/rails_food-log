require 'doorkeeper/grape/helpers'
class  Users < Grape::API
    helpers Doorkeeper::Grape::Helpers
    helpers ApiHelpers::UsersHelper
    # skip_before_action :doorkeeper_authorize!, only: %i[create]
    format :json
    desc 'End-points for shop products'
    namespace :users do
        params do
            requires :email, type: String, desc: 'email'
            requires :password, type: String, desc: 'password'
            requires :client_id, type: String
            requires :client_secret, type: String
        end  
        post do
          user = User.new(email: params[:email], password: params[:password])     
          client_app = Doorkeeper::Application.find_by(uid: params[:client_id])    
          error!("Invalid client Id", 403) unless client_app 
          if user.save
            access_token = Doorkeeper::AccessToken.create(
              resource_owner_id: user.id,
              application_id: client_app.id,
              refresh_token: generate_refresh_token,
              expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
              scopes: ''
            )
            present user: {
                id: user.id,
                email: user.email,
                access_token: access_token.token,
                token_type: 'bearer',
                expires_in: access_token.expires_in,
                refresh_token: access_token.refresh_token,
                created_at: access_token.created_at.to_time.to_i
            }
          else
            present error: error!("Invalid client Id", 403)
          end
        end   
    end  
end
