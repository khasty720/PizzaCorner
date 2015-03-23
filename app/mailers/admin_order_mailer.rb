class AdminOrderMailer < ApplicationMailer


  def order_confirmation(order, admin)
    @order = order
    @user = @order.get_user

    @url  = 'http://example.com/login'
    mail(to: admin.email, subject: ('Cameo Chemicals Order Alert'))
  end
end
