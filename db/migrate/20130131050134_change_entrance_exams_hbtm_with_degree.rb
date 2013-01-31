class ChangeEntranceExamsHbtmWithDegree < ActiveRecord::Migration
  def change
    drop_table :entrance_exams_streams
    create_table :degrees_entrance_exams, :id => false do |t|
      t.integer :degree_id
      t.integer :entrance_exam_id
    end
  end
end
