class AddQtdSubPageToSource < ActiveRecord::Migration
  def self.up
    add_column :sources, :qtdSubPage, :integer
  end

  def self.down
    remove_column :sources, :qtdSubPage
  end
end
