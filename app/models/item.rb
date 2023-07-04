class Item < ApplicationRecord
    has_many :ordered_items, dependent: :destroy
    has_many :orders, through: :ordered_items
end
