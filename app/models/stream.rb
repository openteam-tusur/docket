class Stream < ActiveRecord::Base

  attr_accessible :code, :title, :sector_id, :degrees_attributes

  belongs_to :sector
  belongs_to :plan
  has_many :degrees, :dependent => :destroy
  has_many :intakes, :through => :degrees

  accepts_nested_attributes_for :degrees, :allow_destroy => true

  delegate :title, :to => :sector, :prefix => true, :allow_nil => true
  delegate :year, :to => :plan, :prefix => true

  validates_presence_of :code, :title, :sector_id
  validates_uniqueness_of :code, :scope => [:title, :sector_id, :plan_id]
  validates_uniqueness_of :title, :scope => [:code, :sector_id, :plan_id]

  after_save :check_intakes

  def to_s
    "".tap do |string|
      string << code
      string << "&nbsp;&mdash;&nbsp;"
      string << title
    end.html_safe
  end

  private
    def check_intakes
      degrees.each do |degree|
        old_tuitions = degree.intakes.pluck(:tuition) || []
        new_tuitions = degree.tuitions.try(:delete_if, &:blank?) || []

        next if old_tuitions == new_tuitions

        if (delta = old_tuitions - new_tuitions).any?
          degree.intakes.where(:tuition => delta).destroy_all
        end

        if (delta = new_tuitions - old_tuitions).any?
          delta.each do |tuition|
            intake = degree.intakes.new :tuition => tuition
            intake.save(:validate => false)
          end
        end
      end
    end
end
