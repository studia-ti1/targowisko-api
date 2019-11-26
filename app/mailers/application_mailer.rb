# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'targowisko.team@gmail.com'
  layout 'mailer'
end
