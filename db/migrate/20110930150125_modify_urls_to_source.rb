class ModifyUrlsToSource < ActiveRecord::Migration
  def self.up
    # change_table() yields a Table instance
    change_table(:logs) do |t|
      t.column :urls, :text
    end
  end

  def self.down
  end
end
