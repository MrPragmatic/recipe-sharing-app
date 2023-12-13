# frozen_string_literal: true

# This class serves as the base for all application mailers, providing default settings and reusable methods.
class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@recipe-sharing-app-dqqf.onrender.com'
  layout 'mailer'
end
