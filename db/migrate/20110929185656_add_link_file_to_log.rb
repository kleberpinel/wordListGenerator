class AddLinkFileToLog < ActiveRecord::Migration
  def self.up
    add_column :logs, :link_file, :string
  end

  def self.down
    remove_column :logs, :link_file
  end
end
