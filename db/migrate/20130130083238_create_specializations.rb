class CreateSpecializations < ActiveRecord::Migration
  def change
    create_table :specializations do |t|
      t.string :title
      t.integer :passing_grade
      t.float :density
      t.references :department
      t.references :intake

      t.timestamps
    end
    add_index :specializations, :department_id
  end
end
