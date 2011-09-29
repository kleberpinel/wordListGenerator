class AddLinkFinalExecutionDateToLog < ActiveRecord::Migration
  def self.up
    add_column :logs, :final_execution_date, :date
  end

  def self.down
    remove_column :logs, :final_execution_date
  end
end
