class SearchMailer < ApplicationMailer
  # after_action :prevent_mail_to_saved_searches_with_no_email_sign_up

  def weekly_mail(search, result)
    @new_results = result
    mail(to: search.user.email, subject: "This week's building permits from #{search.address}")
  end

  # def weekly_mail(search) #refactor to (search, result). Make the API call separately, probably in the rake task.
  #   @saved_search = search
  #   @distance = @saved_search.current_url.scan(/distance=(.*)&/).flatten.first
  #   @new_results = BuildingPermitService.new(14, @distance, @saved_search.address).permit_search
  #   mail(to: @saved_search.user.email, subject: "This week's building permits from #{@saved_search.address}")
  # end
  # 
  # private
  #
  # def prevent_mail_to_saved_searches_with_no_email_sign_up
  #   if @saved_search.weekly_email == 0
  #     mail.perform_deliveries = false
  #   end
  # end
end
