class PropertyTokyoMailer < ApplicationMailer
  def notification(properties)
    @properties = properties
    subject = '【新着】東京の新着物件'
    to = 'sh.zxcv00@gmail.com'
    from = 'noreply@example.com'
    mail(to: to, from: from, subject: subject)
  end
end
