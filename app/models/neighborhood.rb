class Neighborhood < ApplicationRecord
  validates :name, :geom, presence: true
end
