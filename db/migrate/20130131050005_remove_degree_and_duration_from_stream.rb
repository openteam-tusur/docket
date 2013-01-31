class RemoveDegreeAndDurationFromStream < ActiveRecord::Migration
  def change
    remove_column :streams, :degree
    remove_column :streams, :duration
  end
end
