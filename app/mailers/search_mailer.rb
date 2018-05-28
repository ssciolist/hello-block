class SearchMailer < ApplicationMailer
  after_action :prevent_mail_to_saved_searches_with_no_email_sign_up

  def weekly_mail(search)
    @saved_search = search
    mail(to: @saved_search.user.email, subject: "This week's building permits from #{saved_search.address}")
  end

  private

  def prevent_mail_to_saved_searches_with_no_email_sign_up
    if @saved_search.weekly_email == 0
      mail.perform_deliveries = false
    end
  end
end