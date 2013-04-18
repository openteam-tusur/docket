class Degree < ActiveRecord::Base
  extend Enumerize
  attr_accessible :tuitions, :code, :entrance_exam_ids
  serialize :tuitions

  belongs_to :stream
  has_and_belongs_to_many :entrance_exams
  has_many :intakes, :dependent => :destroy

  enumerize :code, in: ['62', '65', '68'], default: '62'

  delegate :code, :to => :stream, :prefix => true
  delegate :sector_title, :to => :stream

  validates_presence_of :code, :tuitions, :entrance_exam_ids
  validates_uniqueness_of :code, :scope => [:stream_id]

  def to_s
    "".tap do |string|
      string << "#{stream_code}.#{code}"
      string << "&nbsp;&mdash;&nbsp;"
      string << code_text
    end.html_safe
  end

  def self.code_values
    Hash[code.values.map{|v| [v.to_s, v.text]} ]
  end
end
