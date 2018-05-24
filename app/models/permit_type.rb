class PermitType < ApplicationRecord
  has_many :building_permits

  validates_presence_of :name, :p_type
end
