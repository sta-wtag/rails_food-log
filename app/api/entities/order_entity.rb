module Entities
    class OrderEntity < Grape::Entity
      expose :id
      expose :total_price
      expose :order_status
      expose :created_at 
      expose :updated_at
      expose :user_id
      expose :ordered_items, using: OrderedItemEntity
    end
end