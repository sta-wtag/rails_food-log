class Items < Grape::API
    helpers ApiHelpers::AuthenticationHelper
    before { restrict_access_to_developers }
    before { authenticate! }

    format :json
    desc 'End-points for shop products'
    namespace :items do
        params do
            requires :token, type: String, desc: 'email'
        end
        get do
            items = Item.all
            present items, with: Entities::ItemEntity
        end
    end    
end    