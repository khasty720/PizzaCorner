class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout 'mailer'

  #---- Get Admin User -----
  @admin = User.first
  #-------------------------

end
