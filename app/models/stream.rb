class Stream < ActiveRecord::Base
  extend Enumerize

  belongs_to :sector
  has_and_belongs_to_many :entrance_exams
  attr_accessible :code, :degree, :duration, :title

  enumerize :degree, in: [:bachelor, :magistracy, :specialty], default: :bachelor
  enumerize :duration, in: [:four_years, :five_years] , default: :five_years

end
