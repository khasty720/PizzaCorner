class OrderMailer < ApplicationMailer

  default from: 'PizzaCornerTowson@gmail.com'

  def order_confirmation(order)
    @order = order
    @user = @order.get_user

    mail(to: @user.email, subject: ('Pizza Corner Order Confirmation'))
  end
end
