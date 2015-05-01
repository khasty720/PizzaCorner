class AdminOrderMailer < ApplicationMailer


  def order_confirmation(order, admin)
    @order = order
    @user = @order.get_user
    mail(to: admin.email, subject: ('Pizza Corner Order Alert'))
  end
end
