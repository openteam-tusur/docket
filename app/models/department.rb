class Department < ActiveRecord::Base
  attr_accessible :title, :abbr

  belongs_to :faculty

  has_many :specializations

  validates_presence_of :title, :abbr
  validates_uniqueness_of :title, :abbr, :scope => :faculty_id
end
