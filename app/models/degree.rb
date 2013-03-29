class Degree < ActiveRecord::Base
  extend Enumerize
  attr_accessible :code, :duration, :title, :entrance_exam_ids

  belongs_to :stream
  has_and_belongs_to_many :entrance_exams
  has_many :intakes, :dependent => :destroy

  enumerize :code, in: ['62', '65', '68'], default: '62'
  enumerize :duration, in: [:two_years, :four_years, :five_years, :five_and_half_years, :six_years] , default: :five_years

  delegate :code, :to => :stream, :prefix => true
  delegate :sector_title, :to => :stream

  validates_presence_of :code, :duration, :title, :entrance_exam_ids
  validates_uniqueness_of :code, :scope => [:duration, :title, :stream_id]
  validates_uniqueness_of :title, :scope => [:duration, :code, :stream_id]

  def to_s
    "".tap do |string|
      string << "#{stream_code}.#{code}"
      string << "&nbsp;&mdash;&nbsp;"
      string << title
      string << "&nbsp;&mdash;&nbsp;"
      string << duration_text
    end.html_safe
  end
end
