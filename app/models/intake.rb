class Intake < ActiveRecord::Base
  extend Enumerize

  attr_accessible :duration, :price, :tuition, :year, :specializations_attributes

  belongs_to :degree
  belongs_to :plan

  has_one :stream, :through => :degree
  has_one :sector, :through => :stream

  has_many :specializations, :dependent => :destroy
  has_many :entrance_exams, :through => :degree

  accepts_nested_attributes_for :specializations, :allow_destroy => true

  validates_presence_of :duration, :price
  validates_uniqueness_of :tuition, :scope => [:duration, :degree_id]

  enumerize :duration, in: [:two_years, :four_years, :five_years, :five_and_half_years, :six_years] , default: :four_years
  enumerize :tuition, in: [:fulltime, :extramural, :evening, :remote], default: :fulltime

  delegate :code, :to => :degree, :prefix => true
  delegate :sector_title, :to => :degree

  scope :by_tuition, proc { |tuition| where(:tuition => tuition) }

  searchable do
    string :degree_code,           :multiple => true
    string :entrance_exams_titles, :multiple => true
    string :sector_title
    string :tuition,               :multiple => true
  end

  def self.search_options
    {
      :tuitions  => tuition.options,
      :exams     => EntranceExam.pluck(:title).uniq,
      :sectors   => Sector.pluck(:title).uniq,
      :degrees   => Degree.pluck(:code).uniq
    }
  end

  def self.filter(params = {})
    search(:include => [
        :degree,
        :entrance_exams,
        :sector,
        :specializations,
        :stream
      ]){
      with :degree_code,           params[:degrees]
      with :entrance_exams_titles, params[:exams]    if params[:exams] && params[:exams].present?
      with :sector_title,          params[:sector]   if params[:sector] && params[:sector].present?
      with :tuition,               params[:tuitions] if params[:tuitions] && params[:tuitions].present?
    }.results
  end

  def self.tuition_values
    Hash[tuition.values.map{|v| [v.to_s, v.text]} ]
  end

  def budget
    specializations.sum(:budget)
  end

  def pay_budget
    specializations.sum(:pay_budget)
  end

  def entrance_exams_titles
    entrance_exams.map(&:title)
  end

  def to_s
    ''.tap do |s|
      s << stream.to_s
      s << ', '
      s << degree.code_text.mb_chars.downcase
      s << ', '
      s << tuition_text.mb_chars.downcase
    end
  end
end
