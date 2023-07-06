Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end  
  devise_for :users
  root to: "home#index"
  mount Api => '/'

  # edit_entry GET  '/items/:id/edit(.:format)'  items
  resources :items 
end
