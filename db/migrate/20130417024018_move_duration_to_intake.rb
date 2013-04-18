class MoveDurationToIntake < ActiveRecord::Migration
  def up
    remove_column :degrees, :duration
    add_column :intakes, :duration, :string
  end

  def down
    remove_column :intakes, :duration
    add_column :degrees, :duration, :string
  end
end
