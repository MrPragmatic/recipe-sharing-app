# frozen_string_literal: true

# This class serves as the base for all application mailers, providing default settings and reusable methods.
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
