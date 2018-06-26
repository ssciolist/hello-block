class ScrapedFile < ApplicationRecord
  validates_presence_of :url
  validates :url, uniqueness: true
end
