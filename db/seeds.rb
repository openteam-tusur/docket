# encoding: utf-8

def plan
  Plan.find_or_create_by_year('2013')
end

def import_departments
  puts 'Импорт кафедр ▼'
  array = YAML.load_file(Rails.root.join('data', 'departments.yml')).map { |e| e['subdepartments'] }
  bar = ProgressBar.new(array.flatten!.count)

  array.each do |department_attributes|
    abbr, title = department_attributes['abbr'], department_attributes['title']

    department = plan.departments.find_or_initialize_by_abbr(abbr)
    department.update_attributes title: title
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

def import_streams
  puts 'Импорт направлений подготовки ▼'
  array = YAML.load_file(Rails.root.join('data', 'licences.yml'))
  bar = ProgressBar.new(array['2012'].count)
  array['2012'].each do |element|
    case element['degree']['duration']
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
      p element['degree']
    end
    stream = plan.streams.find_or_create_by_code_and_title(element['code'], element['title'])
    stream.degrees.find_or_create_by_title_and_code_and_duration(element['degree']['title'], element['degree']['code'], duration)
    bar.increment!
  end
end

###############################################################################
import_departments
import_entrance_exams
import_streams
