class PropertyKanagawaMailer < ApplicationMailer
  def notification(properties)
    @properties = properties
    subject = '【新着】神奈川の新着物件'
    to = Rails.application.credentials.mail[:mail1]#, Rails.application.credentials.mail[:mail2]
    from = Rails.application.credentials.mail[:mail3]
    mail(to: to, from: from, subject: subject)
  end
end
