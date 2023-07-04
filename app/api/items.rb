class Items < Grape::API
    helpers ApiHelpers::AuthenticationHelper
    before { restrict_access_to_developers }
    before { authenticate! }
  

    format :json
    desc 'End-points for shop products'
    namespace :items do
        desc 'Get all items'
        get do
            items = Item.all
            present items, with: Entities::ItemEntity
        end
        desc 'Get specific item'
        get ':id' do
            item = Item.find(params[:id])
            present item, with: Entities::ItemEntity 
        end  
        desc 'Create new item'   
        params do
            requires :name, type: String
            requires :description, type: String
            requires :price, type: Integer
            requires :available_quantity, type: Integer
        end
        post do
            isAdmin
            item = Item.create!(params)
            present item, with: Entities::ItemEntity
        end 
        desc 'Update specific item'
        params do
            requires :id, type: Integer 
            optional :name, type: String
            optional :description, type: String
            optional :price, type: Integer
            optional :available_quantity, type: Integer 
        end
        patch ':id' do 
            isAdmin
            item = Item.find(params[:id])
            item.update!({
                name: params[:name] || item.name,
                description: params[:description] || item.description,
                price: params[:price] || item.price,
                available_quantity: params[:available_quantity] || item.available_quantity
            })
            present item,  with: Entities::ItemEntity
        end
        desc 'Delete specific item'
        params do
            requires :id, type: Integer 
        end
        delete ':id' do
            isAdmin
            item = Item.find(params[:id])
            item.destroy
            present item,  with: Entities::ItemEntity
        end         
    end    
end    