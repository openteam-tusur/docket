class RemoveBudgetFromIntake < ActiveRecord::Migration
  def change
    remove_column :intakes, :budget
  end
end
