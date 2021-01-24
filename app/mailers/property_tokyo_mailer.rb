class PropertyTokyoMailer < ApplicationMailer
  def notification(properties)
    @properties = properties
    subject = '【新着】東京の新着物件'
    to = Rails.application.credentials.mail
    from = Rails.application.credentials.mail
    mail(to: to, from: from, subject: subject)
  end
end
