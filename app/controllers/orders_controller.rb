class OrdersController < ApplicationController
    def index
        @orders = Order.all.order(created_at: :desc)
    end  

    def new 
        @order = Order.new
        @order.ordered_items.build
        # Load items to display in the form
        @items = Item.all
    end

    def show 
      @order = Order.includes(ordered_items: :item).find(params[:id])
      @ordered_items = @order.ordered_items.map(&:item)
    end

    def create 

        @order = Order.new(order_params)
        total_price = 0
        
        params[:ordered_items].each do |order_item|
          if order_item[:id]
            item = Item.find(order_item[:id])
            total_price += item.price * order_item[:quantity].to_i
          end
        end
        
        @order.total_price = total_price

        if @order.save
          params[:ordered_items].each do |order_item|
            if order_item[:id]
              item = Item.find(order_item[:id])
              item.update(available_quantity:item.available_quantity-order_item[:quantity].to_i)
              createOrderedItem(@order.id, item, order_item[:quantity].to_i)
            end
          end
          flash[:success] = "Order successfully created"
          redirect_to @order
        else
          flash[:error] = "Something went wrong"
          render 'new'
        end
    end

    def edit 
        @order = Order.find(params[:id])
    end

    def update
        @order = Order.find(params[:id])
        if @order.update(params)
          flash[:success] = "Item was successfully updated"
          redirect_to @item
        else
          flash[:error] = "Something went wrong"
          render :edit, status: :unprocessable_entity
        end
    end 
    def order_params
        params.require(:order).permit( :user_id,:total_price, order_items_attributes: [:item_id, :quantity])
    end
    def createOrderedItem(orderID, item, quantity)
      binding.pry
      OrderedItem.create(order_id: orderID, item_id: item.id, quantity: quantity, price: item.price)
    end  
  
end    