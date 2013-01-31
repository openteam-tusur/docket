class Stream < ActiveRecord::Base

  attr_accessible :code, :title

  belongs_to :sector
  has_many :degrees
  has_many :intakes, :through => :degrees

  def to_s
    "".tap do |string|
      string << code
      string << "&nbsp;&mdash;&nbsp;"
      string << title
    end.html_safe
  end
end
