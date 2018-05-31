desc 'Build the weekly email'
task send_weekly_email: :environment do
  SavedSearch.find_each do |saved_search|
    distance = saved_search.current_url.scan(/distance=(.*)&/).flatten.first
    address = saved_search.scan(/search=(.*)&distance/).flatten.first.gsub('%2C', ',').gsub('+', ' ')
    result = BuildingPermitService.new(14, distance, address).permit_search
    SearchMailer.new.weekly_mail(search, result) if saved_search.weekly_email = 'yes'
  end
end
