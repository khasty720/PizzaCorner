class Order < ActiveRecord::Base
  belongs_to :order_status
  #belongs_to :user


  has_many :order_items, :dependent => :delete_all
  before_create :set_order_status
  before_save :update_subtotal, :update_tax, :update_total
  #before_update :incriment_order_status

  #virtual attr stripe token
  attr_accessor :stripe_token

  def self.get_orders(admin,user)
    if admin == user
      return Order.all
    else
      return Order.where("user_id = ?", user.id)
    end
  end

  def update_order(order_status_id)
    self[:order_status_id] = order_status_id

    if self.save
      return true
    else
      return false
    end
  end

  def update_product_invetory(order)
    order.order_items.each do |order_item|
      order_item.product.count = order_item.product.count - order_item.quantity
      order_item.product.save
    end
  end

  def subtotal
    order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
  end

  def set_user(user)
    self[:user_id] = user.id
  end

  def get_user
    user = User.find(self[:user_id])
    return user
  end

  def make_payment
    MakePaymentService.new.perform(self)
  end

  def incriment_order_status
    status = self.order_status_id
    status = status + 1
    self.order_status_id = status
  end

  private
  def set_order_status
    self.order_status_id = 1
  end

  def update_subtotal
    self[:subtotal] = subtotal
  end

  def update_tax
    self[:tax] = self[:subtotal] * 0.08875
  end

  def update_total
    self[:total] = self[:subtotal] + self[:tax]
  end
end
