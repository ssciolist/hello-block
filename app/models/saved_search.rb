class SavedSearch < ApplicationRecord
  belongs_to :user

  validates_presence_of :current_url

  def distance
    self.current_url.scan(/distance=(.*)&/).flatten.first
  end

  def address
    self.current_url.scan(/search=(.*)\%2C/).flatten.first.gsub('+', ' ')
  end

  def days
    self.current_url.scan(/days=(.*)/).flatten.first
  end
end
