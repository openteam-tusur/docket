class Intake < ActiveRecord::Base
  extend Enumerize

  attr_accessible :budget, :price, :tuition, :year, :specializations_attributes

  belongs_to :degree
  belongs_to :plan

  has_one :stream, :through => :degree
  has_one :sector, :through => :stream

  has_many :specializations, :dependent => :destroy
  has_many :entrance_exams, :through => :degree

  accepts_nested_attributes_for :specializations, :allow_destroy => true

  validates_presence_of :budget, :price, :tuition
  validates_uniqueness_of :tuition, :scope => [:degree_id]

  enumerize :tuition, in: [:fulltime, :extramural, :evening], default: :fulltime

  delegate :code, :to => :degree, :prefix => true
  delegate :sector_title, :to => :degree

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

  def entrance_exams_titles
    entrance_exams.map(&:title)
  end
end
