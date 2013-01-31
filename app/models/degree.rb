class Degree < ActiveRecord::Base
  extend Enumerize
  attr_accessible :code, :duration, :title, :entrance_exam_ids

  belongs_to :stream
  has_and_belongs_to_many :entrance_exams
  has_many :intakes

  accepts_nested_attributes_for :entrance_exams

  enumerize :code, in: ['62', '65', '68'], default: '62'
  enumerize :duration, in: [:two_years, :four_years, :five_years, :five_and_half_years, :six_years] , default: :five_years

  def to_s
    "".tap do |string|
      string << code
      string << "&nbsp;&mdash;&nbsp;"
      string << title
      string << "&nbsp;&mdash;&nbsp;"
      string << duration_text
    end.html_safe
  end
end
