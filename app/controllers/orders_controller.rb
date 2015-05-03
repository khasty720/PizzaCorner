class OrdersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_order, only: [:update_status, :status, :edit]

  def index
    @orders = Order.get_orders(@admin, current_user)
  end

  def show
    #@order = current_order
    @order = Order.find params[:id]
    @user = @order.get_user
  end

  def status
    unless (@admin == current_user || current_user.employee == true || @order.user_id = current_user.id)
      redirect_to root_path, :alert => "Access denied."
    end

    @order = Order.find params[:id]
    @user = @order.get_user
  end

  def edit
    @user = @order.get_user
  end

  def update
    @order = Order.find params[:id]

    respond_to do |format|
      if @order.update(order_params)

        #----- Update Invetory Count ----
        @order.update_product_invetory(@order)

        # Tell the UserMailer to send a welcome email after save
        OrderMailer.order_confirmation(@order).deliver_now
        AdminOrderMailer.order_confirmation(@order, @admin).deliver_now

        #--- Clear Session ---
        session[:order_id] = nil

        format.html { redirect_to root_path, notice: 'Order was submitted successfully.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_status
    #raise params.inspect

    respond_to do |format|
      #if @order.update_order(params[:order_status_id])
      if @order.update(order_params)
        format.html { redirect_to show_order_status_path(@order), notice: 'Order was successfully updated.' }
        format.json { render :status, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
  
    @order = Order.find params[:id]
    if (@admin == current_user || @order.get_user == current_user)
      @order.destroy
      session[:order_id] = nil
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Order was canceled successfully.' }
        format.json { head :no_content }
      end
    else
      redirect_to root_path, :alert => "Access denied."
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.require(:order).permit(:subtotal, :tax, :shipping, :total, :user_id, :street, :city, :state, :zip, :country, :order_status_id, :delivery, :card_code, :card_year, :card_month, :card_number)
  end


end
