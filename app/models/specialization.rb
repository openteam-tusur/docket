class Specialization < ActiveRecord::Base
  attr_accessible :density, :passing_grade, :title, :department_id

  belongs_to :department
  belongs_to :intake
end
