# encoding: utf-8

require 'csv'

def plan
  Plan.find_or_create_by_year('2013')
end

def import_departments
  puts 'Импорт кафедр ▼'
  array = YAML.load_file(Rails.root.join('data', 'departments.yml'))
  bar = ProgressBar.new(array.count)

  array.each do |faculty_attributes|
    faculty = plan.faculties.find_or_create_by_abbr_and_title :abbr => faculty_attributes['abbr'], :title => faculty_attributes['title']
    faculty_attributes['subdepartments'].each do |subdepartment_attributes|
      faculty.departments.find_or_create_by_abbr_and_title :abbr => subdepartment_attributes['abbr'], :title => subdepartment_attributes['title']
    end
    bar.increment!
  end
end

def import_entrance_exams
  puts 'Импорт вступительных экзаменов ▼'
  array = YAML.load_file(Rails.root.join('data', 'entrance_exams.yml'))['entrance_exams']
  bar = ProgressBar.new(array.count)
  array.each do |element|
    plan.entrance_exams.find_or_create_by_title(element)
    bar.increment!
  end
end

def import_sectors
  puts 'Импорт отраслей ▼'
  array = YAML.load_file(Rails.root.join('data', 'sectors.yml'))['sectors']
  bar = ProgressBar.new(array.count)
  array.each do |element|
    plan.sectors.find_or_create_by_title(element)
    bar.increment!
  end
end

def prepared_hash
  csv_data = CSV.read(Rails.root.join('data/streams.csv'), :col_sep => ';', :converters => [->(f){ f.strip if f}])
  headers = csv_data.shift.map {|i| i.to_s }
  string_data = csv_data.map {|row| row.map {|cell| cell.to_s } }
  string_data.map {|row| Hash[*headers.zip(row).flatten] }
end

def import_streams
  puts 'Импорт направлений подготовки ▼'
  bar = ProgressBar.new(prepared_hash.size)
  prepared_hash.each do |record|
    stream = plan.streams.find_or_create_by_code_and_title(:code => record['code'], :title => record['str_title'], :sector_id => 1 )

    case record['duration']
    when '2'
      duration = :two_years
    when '4'
      duration = :four_years
    when '5'
      duration = :five_years
    when '5.5'
      duration = :five_and_half_years
    when '6'
      duration = :six_years
    else
      p record['degree']
    end

    case record['degree']
    when '62'
      title = 'Бакалавр'
    when '65'
     title = 'Специалист'
    else
      p record['degree']
    end

    degree = stream.degrees.find_or_initialize_by_code(:code => record['degree']) do |d|
      if d.new_record?
        d.tuitions = ['fulltime']
        d.entrance_exam_ids = plan.entrance_exams.where(:title => record['exams'].split(', ')).map(&:id)
        d.save!(:validate => false)
      end
    end

    intake = degree.intakes.find_or_initialize_by_duration_and_tuition(:duration => duration, :tuition => :fulltime) do |i|
      i.save!(:validate => false) if i.new_record?
    end

    specialization = intake.
      specializations.
      find_or_create_by_budget_and_density_and_department_id_and_passing_grade_and_pay_budget_and_title(
        :budget => 0,
        :density => 0,
        :department_id => Department.find_by_abbr(record['dep']).id,
        :passing_grade => 0,
        :pay_budget => 0,
        :title => record['prf_title']
      )

    bar.increment!
  end
end

###############################################################################
import_departments
import_entrance_exams
import_sectors
import_streams
