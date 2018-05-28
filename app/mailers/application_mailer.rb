class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@hello'
  layout 'mailer'
end
