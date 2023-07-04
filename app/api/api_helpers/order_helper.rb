module ApiHelpers
    module OrderHelper
         def createOrderedItem(ordered_items, order_id)
            ordered_items.each do |ordered_item|
                item = Item.find(ordered_item[:id])
                OrderedItem.create!({
                    order_id: order_id,
                    item_id: ordered_item[:id],
                    quantity: ordered_item[:quantity]
                })
                item.update({
                    available_quantity: item.available_quantity - ordered_item[:quantity]
                })
            end 
         end   
    end
end