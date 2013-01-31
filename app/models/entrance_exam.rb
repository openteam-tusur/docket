class EntranceExam < ActiveRecord::Base
  attr_accessible :title
  belongs_to :plan
  has_and_belongs_to_many :streams
end
