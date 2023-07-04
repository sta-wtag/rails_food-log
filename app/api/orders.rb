class Orders < Grape::API
    helpers ApiHelpers::AuthenticationHelper
    helpers ApiHelpers::OrderHelper
    before { restrict_access_to_developers }
    before { authenticate! }

    format :json
    desc 'End-points for shop orders'
    namespace :orders do
        get do
            isAdmin
            orders = Order.all
            present orders, with: Entities::OrderEntity
        end
        desc 'Get specific order'
        get ':id' do
            order = Order.find(params[:id])
            present order, with: Entities::OrderEntity
        end 
        
        desc 'Create a new order'
        params do
            requires :user_id, type: Integer
            requires :ordered_items, type: Array 
        end    
        post do
            isAdmin
            total_quantity = 0 
            total_price = 0
            params[:ordered_items].each do |ordered_item|
                item = Item.find(ordered_item[:id])
                quantity = ordered_item[:quantity]
                if quantity > item.available_quantity
                    error!("Not enough #{item.name} in stock", INVALID_PARAMS)
                end
                total_quantity += quantity
                total_price += item.price * quantity
            end 
            if total_quantity == 0
                error!("Please select at least one item", INVALID_PARAMS)
            end   
            order = Order.create!({
                user_id: params[:user_id],
                total_price: total_price
            })
            createOrderedItem(params[:ordered_items], order.id)
        end    
    end
end