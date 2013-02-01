class Specialization < ActiveRecord::Base
  attr_accessible :density, :passing_grade, :title, :department_id

  belongs_to :department
  belongs_to :intake

  delegate :abbr, :to => :department, :prefix => true
  delegate :title, :to => :department, :prefix => true
end
