class Stream < ActiveRecord::Base
  belongs_to :sector
  attr_accessible :code, :degree, :duration, :title
  has_and_belongs_to_many :entrance_exams
end
