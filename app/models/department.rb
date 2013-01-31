class Department < ActiveRecord::Base
  attr_accessible :title

  belongs_to :plan

  has_many :specializations

  scope :ordered_by_title, -> { order :title }
end
