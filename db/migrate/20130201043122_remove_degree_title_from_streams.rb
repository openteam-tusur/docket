class RemoveDegreeTitleFromStreams < ActiveRecord::Migration
  def change
    remove_column :streams, :degree_title
  end
end
