class Items < Grape::API
    helpers ApiHelpers::AuthenticationHelper
    before { restrict_access_to_developers }
    before { authenticate! }

    format :json
    desc 'End-points for shop products'
    namespace :items do
        get do
            items = Item.all
            present items, with: Entities::ItemEntity
        end
        params do
            requires :name, type: String
            requires :description, type: String
            requires :price, type: Integer
            requires :available_quantity, type: Integer
        end
        post do
            item = Item.create(params)

            present item, with: Entities::ItemEntity
        end    
    end    
end    