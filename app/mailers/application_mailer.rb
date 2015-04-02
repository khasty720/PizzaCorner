class ApplicationMailer < ActionMailer::Base
  default from: 'PizzaCorner@gmail.com'
  layout 'mailer'

  #---- Get Admin User -----
  @admin = User.first
  #-------------------------

end
