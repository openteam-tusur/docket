def import_departments
  array = YAML.load_file(Rails.root.join('data', 'departments.yml')).map { |e| e['subdepartments'] }

  array.each do |element|
    element.each do |department_attributes|
      abbr, title = department_attributes['abbr'], department_attributes['title']

      department = Department.find_or_initialize_by_abbr(abbr)
      department.update_attributes title: title
    end
  end
end

import_departments
