class Order < ActiveRecord::Base
  #validates :card_number, presence: true, length: { is: 16 }
  #validates :card_code, presence: true, length: { is: 3 }
  #validates :card_number, length: { is: 16 }
  #validates :card_code, length: { is: 3 }

  belongs_to :order_status

  has_many :order_items, :dependent => :delete_all
  before_create :set_order_status, :set_defaul_values
  before_save :update_subtotal, :update_tax, :update_total


  def self.get_orders(admin,user)
    if (admin == user || user.employee == true)
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


  def incriment_order_status
    status = self.order_status_id
    status = status + 1
    self.order_status_id = status
  end

  private
  def set_order_status
    self.order_status_id = 1
  end

  def set_defaul_values
    self.card_number = "0000000000000000"
    self.card_code = "000"
  end

  def update_subtotal
    self[:subtotal] = subtotal
  end

  def update_tax
    self[:tax] = self[:subtotal] * 0.06
  end

  def update_total
    self[:total] = self[:subtotal] + self[:tax]
  end
end
