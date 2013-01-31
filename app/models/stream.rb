class Stream < ActiveRecord::Base
  extend Enumerize

  belongs_to :sector
  has_and_belongs_to_many :entrance_exams
  has_many :intakes
  attr_accessible :code, :degree, :duration, :title

  enumerize :degree, in: ['62', '65', '68'], default: '62'
  enumerize :duration, in: [:two_years, :four_years, :five_years, :five_and_half_years, :six_years] , default: :five_years

  def to_s
    "".tap do |string|
      string << code
      string << "&nbsp;&mdash;&nbsp;"
      string << title
    end.html_safe
  end
end
