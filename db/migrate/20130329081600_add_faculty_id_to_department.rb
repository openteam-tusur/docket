class AddFacultyIdToDepartment < ActiveRecord::Migration
  def change
    add_column :departments, :faculty_id, :integer
  end
end
