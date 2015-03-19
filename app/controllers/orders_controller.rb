class OrdersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @order = Order.all
  end

  def show
    @order = current_order
    @user = @order.get_user
  end

  def edit
  end

  def update
    @order = Order.find params[:id]

    respond_to do |format|
      if @order.update(order_params)
        @order.make_payment
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.require(:order).permit(:subtotal, :tax, :shipping, :total, :user_id, :stripe_token, :street, :city, :state, :zip, :country)
  end


end
