class ApplicationMailer < ActionMailer::Base
  default from: 'cameochem@gmail.com'
  layout 'mailer'

  #---- Get Admin User -----
  @admin = User.first
  #-------------------------

end
