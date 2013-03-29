class Specialization < ActiveRecord::Base
  attr_accessible :density, :passing_grade, :title, :department_id

  belongs_to :department
  belongs_to :intake

  delegate :abbr, :to => :department, :prefix => true
  delegate :title, :to => :department, :prefix => true

  validates_presence_of :density, :passing_grade, :title, :department_id
  validates_uniqueness_of :title, :scope => [:department_id, :intake_id]

end
