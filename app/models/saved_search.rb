class SavedSearch < ApplicationRecord
  belongs_to :user
  enum weekly_email: %w(no yes)

  validates_presence_of :current_url
  before_save :generate_address

  def distance
    self.current_url.scan(/distance=(.*)&/).flatten.first
  end

  def generate_address
    self.address = self.current_url.scan(/search=(.*)\%2C/).flatten.first.gsub('+', ' ')
  end

  def days
    self.current_url.scan(/days=(.*)/).flatten.first
  end
end
