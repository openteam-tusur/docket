class Faculty < ActiveRecord::Base
  attr_accessible :abbr, :title, :departments_attributes

  belongs_to :plan

  has_many :departments, :dependent => :destroy

  accepts_nested_attributes_for :departments, :allow_destroy => true

  validates_presence_of :title, :abbr
  validates_uniqueness_of :title, :abbr, :scope => :plan_id
end
