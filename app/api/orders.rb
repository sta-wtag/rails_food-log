class Orders < Grape::API
    helpers ApiHelpers::OrderHelper
    helpers ApiHelpers::UsersHelper
    helpers Doorkeeper::Grape::Helpers
    before {doorkeeper_authorize!}

    format :json
    desc 'End-points for shop orders'
    namespace :orders do
        get do
            isAdmin(current_user)
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
        params do
            optional :user_id, type: Integer
            optional :ordered_items, type: Array 
        end 
        patch ':id' do
            isAdmin(current_user)
            order = Order.find(params[:id])
            if !order.disputed?
                order.update!({
                    total_price: params[:total_price] || order.total_price,
                    order_status: params[:order_status] || order.order_status
                })
            else   
                error_msg = 'The order is already disputed.Can not update it.'
                error!({ 'error_msg' => error_msg }, 404) 
            end
            present order,  with: Entities::OrderEntity
        end   
        patch ':id/cancel_order' do
            order = Order.find(params[:id])
            if !order.disputed?
                order.update!({
                    order_status: 6
                })
            else   
                error_msg = 'The order is already disputed.Can not update it.'
                error!({ 'error_msg' => error_msg }, 404) 
            end
            
            present order,  with: Entities::OrderEntity
        end 
        patch ':id/confirm_order' do
            order = Order.find(params[:id])
            if !order.disputed?
                order.update!({
                    order_status: 2
                })
            else   
                error_msg = 'The order is already disputed.Can not update it.'
                error!({ 'error_msg' => error_msg }, 404) 
            end
            
            present order,  with: Entities::OrderEntity
        end 
        delete ':id' do
            isAdmin(current_user)
            order = Order.find(params[:id])
            if order.pending?
                order.destroy
            else   
                error_msg = 'Can not delete this order'
                error!({ 'error_msg' => error_msg }, 404) 
            end
        end    

    end
end