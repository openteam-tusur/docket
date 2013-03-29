class EntranceExam < ActiveRecord::Base
  attr_accessible :title

  belongs_to :plan

  has_and_belongs_to_many :degrees

  validates_presence_of :title
  validates_uniqueness_of :title, :scope => :plan_id
end
