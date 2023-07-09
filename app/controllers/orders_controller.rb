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
        @order = Order.find(params[:id])
    end

    def create 
        @order = Order.new(order_params)
        if @order.save
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
        params.require(:order).permit(order_items_attributes: [:item_id, :quantity])
    end
  
end    