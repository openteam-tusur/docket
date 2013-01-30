class CreateEntranceExamsStreams < ActiveRecord::Migration
  def change
    create_table :entrance_exams_streams, :id => false do |t|
      t.integer :entrance_exam_id
      t.integer :stream_id
    end
  end
end
