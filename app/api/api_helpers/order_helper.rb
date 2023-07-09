module ApiHelpers
    module OrderHelper
         def createOrderedItem(ordered_items, order_id)
            ordered_items.each do |ordered_item|
                item = Item.find(ordered_item[:id])
                OrderedItem.create!({
                    order_id: order_id,
                    item_id: ordered_item[:id],
                    quantity: ordered_item[:quantity],
                    price: item.price
                })
                item.update({
                    available_quantity: item.available_quantity - ordered_item[:quantity]
                })
            end 
         end  
         def isAdmin(current_user)
            unless current_user.role == 'admin' 
              AuditLog.create data: 'Access Denied'
              error!({ :error_msg => "permission_error", :error_code => ErrorCodes::PERMISSION_ERROR }, 404)
            end  
          end  
    end
end