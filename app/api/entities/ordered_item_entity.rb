module Entities
    class OrderedItemEntity < Grape::Entity
      expose :item, using: ItemOrderedEntity 
    end
end