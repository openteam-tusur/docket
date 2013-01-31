class CreateDegrees < ActiveRecord::Migration
  def change
    create_table :degrees do |t|
      t.string :code
      t.string :title
      t.string :duration
      t.references :stream

      t.timestamps
    end
    add_index :degrees, :stream_id
  end
end
