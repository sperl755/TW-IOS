class ModifyTaskLocation < ActiveRecord::Migration
  def self.up
    rename_column :task_locations, :country, :country_id
    change_column :task_locations, :country_id, :integer
  end

  def self.down
    rename_column :task_locations, :country_id, :country
    change_column :task_locations, :country, :string
  end
end
