class ChangeEntranceExamsHbtmWithDegree < ActiveRecord::Migration
  def change
    drop_table :entrance_exams_streams
    create_table :entrance_exams_degrees, :id => false do |t|
      t.integer :entrance_exam_id
      t.integer :stream_id
    end
  end
end
