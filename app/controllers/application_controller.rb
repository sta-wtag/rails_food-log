
class ApplicationController < ActionController::Base
  def current_user
    if doorkeeper_token.present?
        @current_user ||= User.find_by(id: doorkeeper_token[:resource_owner_id])
    else
        @current_user = User.find_by(id:1)
    end
  end 
  
end
