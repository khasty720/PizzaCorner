class CartsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  def show
    @order_items = current_order.order_items
  end

  private

end
