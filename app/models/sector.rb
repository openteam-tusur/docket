class Sector < ActiveRecord::Base
  attr_accessible :title

  belongs_to :plan

  has_many :streams

  validates_presence_of :title
  validates_uniqueness_of :title, :scope => :plan_id
end
