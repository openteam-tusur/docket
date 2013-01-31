class AddPlanReferencesToDictionaries < ActiveRecord::Migration
  def change
    add_column :departments,    :plan_id, :integer
    add_column :entrance_exams, :plan_id, :integer
    add_column :sectors,        :plan_id, :integer
    add_column :streams,        :plan_id, :integer
  end
end
