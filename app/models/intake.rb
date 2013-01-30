class Intake < ActiveRecord::Base
  extend Enumerize

  belongs_to :stream
  has_many :specializations
  attr_accessible :budget, :price, :tuition, :year

  enumerize :tuition, in: [:fulltime, :extramural, :evening], default: :fulltime
end
