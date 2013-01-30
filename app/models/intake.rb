class Intake < ActiveRecord::Base
  belongs_to :stream
  attr_accessible :budget, :price, :tuition, :year
  has_many :specializations
end
