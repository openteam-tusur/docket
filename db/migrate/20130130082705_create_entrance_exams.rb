class CreateEntranceExams < ActiveRecord::Migration
  def change
    create_table :entrance_exams do |t|
      t.string :title

      t.timestamps
    end
  end
end
