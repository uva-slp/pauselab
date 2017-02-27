class SlpMailer < ApplicationMailer
    default from: 'PauseLab Inc.'
    #For some reason the default doesn't work if I only put in PauseLab... why?

  def email_self
    mail(to: 'goldjet45@gmail.com', subject: 'Heyooo oscar')
  end

  def email_users
    mail(to: User.pluck(:email), subject: 'ATTENTION PauseLab artists')
  end

  def email_custom_text(to, subj, body)
    mail(to: to,
         subject: subj,
         body: body)
  end

  def email_custom_html(to, subj, body)
    mail(to: to,
         subject: subj,
         body: body,
         content_type: "text/html")
  end

end
