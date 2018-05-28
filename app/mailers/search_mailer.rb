class SearchMailer < ApplicationMailer
  after_action :prevent_mail_to_saved_searches_with_no_email_sign_up

  def weekly_mail(search)
    binding.pry
    @saved_search = search
  end

  private

  def prevent_mail_to_saved_searches_with_no_email_sign_up
    if @saved_search.weekly_email == 0
      mail.perform_deliveries = false
    end
  end
end
