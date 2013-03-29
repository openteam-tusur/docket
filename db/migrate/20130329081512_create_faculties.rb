class CreateFaculties < ActiveRecord::Migration
  def change
    create_table :faculties do |t|
      t.string :abbr
      t.string :title
      t.references :plan

      t.timestamps
    end
    add_index :faculties, :plan_id
  end
end
