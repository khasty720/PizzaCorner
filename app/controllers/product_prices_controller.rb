class ProductPricesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_product_price, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @product_prices = ProductPrice.all
    respond_with(@product_prices)
  end

  def show
    respond_with(@product_price)
  end

  def new
    unless @admin == current_user
      redirect_to root_path, :alert => "Access denied."
    end
    @product_price = ProductPrice.new
    respond_with(@product_price)
  end

  def edit
    unless @admin == current_user
      redirect_to root_path, :alert => "Access denied."
    end
  end

  def create
    @product_price = ProductPrice.new(product_price_params)
    @product_price.save
    respond_with(@product_price)
  end

  def update
    @product_price.update(product_price_params)
    respond_with(@product_price)
  end

  def destroy
    if @admin == current_user
      @product_price.destroy
      respond_with(@product_price)
    else
      redirect_to root_path, :alert => "Access denied."
    end
  end

  private
    def set_product_price
      @product_price = ProductPrice.find(params[:id])
    end

    def product_price_params
      params.require(:product_price).permit(:price, :active, :user_id, :product_id)
    end
end
