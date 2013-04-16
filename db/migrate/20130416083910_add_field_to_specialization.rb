class AddFieldToSpecialization < ActiveRecord::Migration
  def change
    add_column :specializations, :budget, :integer
    add_column :specializations, :pay_budget, :integer
  end
end
