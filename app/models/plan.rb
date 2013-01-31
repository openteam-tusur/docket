class Plan < ActiveRecord::Base
  attr_accessible :year
  has_many :departments
  has_many :entrance_exams
  has_many :sectors
  has_many :streams
  has_many :intakes, :through => :streams
end
