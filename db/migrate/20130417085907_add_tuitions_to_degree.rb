class AddTuitionsToDegree < ActiveRecord::Migration
  def change
    add_column :degrees, :tuitions, :string
  end
end
