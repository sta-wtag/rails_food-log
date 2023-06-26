module Entities
    class ItemEntity < Grape::Entity
      expose :id
      expose :name
      expose :description
      expose :price 
      expose :available_quantity
    end
end