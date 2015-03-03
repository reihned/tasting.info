class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@tasting.info"
  layout 'mailer'
end
