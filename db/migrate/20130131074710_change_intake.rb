class ChangeIntake < ActiveRecord::Migration
  def change
    rename_column :intakes, :stream_id, :degree_id
  end
end
