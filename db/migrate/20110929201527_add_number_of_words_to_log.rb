class AddNumberOfWordsToLog < ActiveRecord::Migration
  def self.up
    add_column :logs, :number_of_words, :integer
  end

  def self.down
    remove_column :logs, :number_of_words
  end
end
