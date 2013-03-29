class RemovePlanIdFromDepartments < ActiveRecord::Migration
  def change
    remove_column :departments, :plan_id
  end
end
