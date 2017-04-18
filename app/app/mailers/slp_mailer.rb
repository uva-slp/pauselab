class SlpMailer < ApplicationMailer
    default from: '"PauseLab" <slp.pauselab@gmail.com>'

  def email_custom_text(to, subj, body)
    mail(to: to,
         subject: subj,
         body: body)
  end

  def email_custom_text_bcc(bcc, subj, body)
    mail(bcc: bcc,
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
