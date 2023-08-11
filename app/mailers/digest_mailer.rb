class DigestMailer < ApplicationMailer
  def weekly_summary(email, summary)
    @summary = summary
    mail(to: email, subject: 'Your Weekly Student Activity Summary')
  end
end
