class OrderMailer < ApplicationMailer

  default from: 'PizzaCorner@gmail.com'

  def order_confirmation(order)
    @order = order
    @user = @order.get_user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: ('Cameo Chemicals Order Reciept'))
  end
end
