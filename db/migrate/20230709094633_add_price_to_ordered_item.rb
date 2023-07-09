class AddPriceToOrderedItem < ActiveRecord::Migration[6.1]
  def change
    add_column :ordered_items, :price, :integer
  end
end
