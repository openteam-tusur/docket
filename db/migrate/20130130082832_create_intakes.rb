class CreateIntakes < ActiveRecord::Migration
  def change
    create_table :intakes do |t|
      t.string :year
      t.string :tuition
      t.integer :budget
      t.integer :price
      t.references :stream

      t.timestamps
    end
    add_index :intakes, :stream_id
  end
end
