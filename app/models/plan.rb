class Plan < ActiveRecord::Base
  attr_accessible :year
  has_many :faculties, :dependent => :destroy
  has_many :departments, :through => :faculties
  has_many :entrance_exams, :dependent => :destroy
  has_many :sectors, :dependent => :destroy
  has_many :streams, :dependent => :destroy
  has_many :intakes, :through => :streams
  has_many :specializations, :through => :intakes

  validates_presence_of :year
  validates_uniqueness_of :year
  validates_format_of :year, :with => /\d{4}/

  after_create :copy_info_from_prev_year

  private

    def copy_info_from_prev_year
      return unless prev_plan = Plan.find_by_year((year.to_i-1).to_s)

      prev_plan.sectors.each do |sector|
        self.sectors.create :title => sector.title
      end

      prev_plan.faculties.each do |faculty|
        f = self.faculties.create(:title => faculty.title, :abbr => faculty.abbr)

        faculty.departments.each do |department|
          f.departments.create :title => department.title, :abbr => department.abbr
        end
      end

      prev_plan.entrance_exams.each do |entrance_exam|
        self.entrance_exams.create :title => entrance_exam.title
      end

      prev_plan.streams.each do |stream|
        self.streams.create :code => stream.code,
                           :title => stream.code,
                           :sector_id => self.sectors.find_by_title(stream.sector.title).id,
                           :degrees_attributes => stream.degrees.map{|d|
                             {
                               :code => d.code,
                               :entrance_exam_ids => self.entrance_exams.where(:title => d.entrance_exams.map(&:title)).map(&:id),
                               :tuitions => d.tuitions
                             }
                           }
      end
    end
end
