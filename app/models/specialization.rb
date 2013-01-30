class Specialization < ActiveRecord::Base
  belongs_to :department
  belongs_to :intake
  attr_accessible :density, :passing_grade, :title
end
