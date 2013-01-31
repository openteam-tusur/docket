class AddDegreeTitleToStream < ActiveRecord::Migration
  def change
    add_column :streams, :degree_title, :string
  end
end
