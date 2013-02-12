class Stream < ActiveRecord::Base

  attr_accessible :code, :title

  belongs_to :sector
  belongs_to :plan
  has_many :degrees
  has_many :intakes, :through => :degrees

  delegate :title, :to => :sector, :prefix => true, :allow_nil => true
  delegate :year, :to => :plan, :prefix => true

  def to_s
    "".tap do |string|
      string << code
      string << "&nbsp;&mdash;&nbsp;"
      string << title
    end.html_safe
  end
end
