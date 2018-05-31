class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@hello-block.herokuapp.com'
  layout 'mailer'
end
