class EntranceExam < ActiveRecord::Base
  attr_accessible :title
  has_and_belongs_to_many :streams
end
