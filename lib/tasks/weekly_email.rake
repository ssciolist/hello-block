desc 'Build the weekly email'
task send_weekly_email: :environment do
  if Time.now.monday?
    SavedSearch.find_each do |saved_search|
      distance = saved_search.current_url.scan(/distance=(.*)&/).flatten.first
      result = BuildingPermitService.new(7, distance, saved_search.address).permit_search
      SearchMailer.weekly_mail(saved_search, result, distance).deliver_now if saved_search.weekly_email == 'yes'
    end
  end
end
