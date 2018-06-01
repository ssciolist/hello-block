desc 'Build the weekly email'
task send_weekly_email: :environment do
  SavedSearch.find_each do |saved_search|
    distance = saved_search.current_url.scan(/distance=(.*)&/).flatten.first
    address = saved_search.current_url.scan(/search=(.*)&distance/).flatten.first.gsub('%2C', ',').gsub('+', ' ')
    result = BuildingPermitService.new(7, distance, address).permit_search
    SearchMailer.weekly_mail(saved_search, result, distance).deliver_now
  end
end
