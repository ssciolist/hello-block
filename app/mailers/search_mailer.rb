class SearchMailer < ApplicationMailer
  def weekly_mail(search, result, distance)
    @new_results = result
    @saved_search = search
    @distance = distance
    mail(to: search.user.email, subject: "This week's building permits from #{search.address}")
  end
end
