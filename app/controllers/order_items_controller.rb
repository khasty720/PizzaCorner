class OrderItemsController < ApplicationController
  def create
    @order = current_order
    @order_item = @order.order_items.new(order_item_params)
    #Asign Correct Price
    @order_item.unit_price = @order_item.set_unit_price(order_item_params[:product_id], current_user)
    @order.set_user(current_user)
    @order.save
    session[:order_id] = @order.id


    #respond_to do |format|
    #  format.html {redirect_to cart_path, notice: 'Item successfully added to cart.'}
    #end

  end

  def update
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.update_attributes(order_item_params)
    @order_items = @order.order_items
  end

  def destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @order.order_items
  end

  private
  def order_item_params
    params.require(:order_item).permit(:quantity, :unit_price, :product_id, :user_id)
  end
end
