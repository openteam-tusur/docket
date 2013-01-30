class Sector < ActiveRecord::Base
  attr_accessible :title
  has_many :streams
end
