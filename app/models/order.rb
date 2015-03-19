class Order < ActiveRecord::Base
  belongs_to :order_status
  #belongs_to :user

  has_many :order_items
  before_create :set_order_status
  before_save :update_subtotal, :update_tax, :update_total

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
