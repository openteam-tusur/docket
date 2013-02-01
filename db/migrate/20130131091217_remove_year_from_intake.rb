class RemoveYearFromIntake < ActiveRecord::Migration
  def change
    remove_column :intakes, :year
  end
end
