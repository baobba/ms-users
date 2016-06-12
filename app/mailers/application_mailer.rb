class ApplicationMailer < ActionMailer::Base
  default from: "userms@userms.herokuapp.com"
  layout 'mailer'
end
