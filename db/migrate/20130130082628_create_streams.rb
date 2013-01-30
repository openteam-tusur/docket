class CreateStreams < ActiveRecord::Migration
  def change
    create_table :streams do |t|
      t.string :code
      t.string :title
      t.string :duration
      t.string :degree
      t.references :sector

      t.timestamps
    end
    add_index :streams, :sector_id
  end
end
