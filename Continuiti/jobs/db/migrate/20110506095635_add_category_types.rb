class AddCategoryTypes < ActiveRecord::Migration
  def self.up
    add_column :categories, :ctype, :string
    add_column :categories, :active, :boolean, :default=>0
    change_column :jobs, :time_unit, :integer
  end

  def self.down
    remove_column :categories, :ctype
    remove_column :categories, :active
    change_column :jobs, :time_unit, :string
  end
end
