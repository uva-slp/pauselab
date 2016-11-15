class SlpMailer < ApplicationMailer
    default from: 'King of the Hill'  
  
  def email_self
    mail(to: 'goldjet45@gmail.com', subject: 'Heyooo oscar')
  end
end
