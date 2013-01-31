class Intake < ActiveRecord::Base
  extend Enumerize

  attr_accessible :budget, :price, :tuition, :year, :specializations_attributes

  belongs_to :degree
  belongs_to :plan

  has_many :specializations, :dependent => :destroy

  accepts_nested_attributes_for :specializations, :allow_destroy => true

  enumerize :tuition, in: [:fulltime, :extramural, :evening], default: :fulltime
end
