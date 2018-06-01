class SearchMailer < ApplicationMailer
  def weekly_mail(search, result)
    @new_results = result
    mail(to: search.user.email, subject: "This week's building permits from #{search.address}")
  end
end
