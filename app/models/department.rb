class Department < ActiveRecord::Base
  attr_accessible :title
  belongs_to :plan
  has_many :specializations
end
