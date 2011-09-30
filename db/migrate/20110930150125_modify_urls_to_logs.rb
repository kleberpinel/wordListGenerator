class ModifyUrlsToLogs < ActiveRecord::Migration
  def self.up
    change_column(:logs, :urls, :text)
  end

  def self.down
  end
end
